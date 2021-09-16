import 'package:eastarrow_web/presentation/dashboard/dashboard_page.dart';
import 'package:eastarrow_web/presentation/errors/forbidden_page.dart';
import 'package:eastarrow_web/presentation/errors/internal_error_page.dart';
import 'package:eastarrow_web/presentation/errors/not_found_page.dart';
import 'package:eastarrow_web/presentation/goods/add_goods/add_goods_page.dart';
import 'package:eastarrow_web/presentation/goods/edit_goods/edit_goods_page.dart';
import 'package:eastarrow_web/presentation/goods/goods_detail/goods_detail_page.dart';
import 'package:eastarrow_web/presentation/goods/goods_list/goods_list_page.dart';
import 'package:eastarrow_web/presentation/login/login_page.dart';
import 'package:eastarrow_web/presentation/member/member_detail/member_detail_page.dart';
import 'package:eastarrow_web/presentation/member/member_list/member_list_page.dart';
import 'package:eastarrow_web/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

/// WebRouterを生成するクラス
class RouterFactory {
  /// WebRouterを生成する
  static WebRouter create() {
    final router = WebRouter();
    router.addForbiddenRoute(_pageBuilder(ForbiddenPage()));
    router.addNotFoundRoute(_pageBuilder(NotFoundPage()));
    router.addInternalErrorRoute(_pageBuilder(InternalErrorPage()));

    /// ページを追加したら必ずここにも追加すること
    router.addRoute(kRouteLogin, _pageBuilder(LoginPage()));
    router.addRoute(kRouteDashboard, _pageBuilder(DashboardPage()));
    router.addRoute(kRouteAddGoods, _pageBuilder(AddGoodsPage()));
    router.addRoute(kRouteGoodsList, _pageBuilder(GoodsListPage()));
    router.addRoute(kRouteGoodsDetail, _pageBuilder(GoodsDetailPage()));
    router.addRoute(kRouteGoodsEdit, _pageBuilder(EditGoodsPage()));
    router.addRoute(kRouteMembersIndex, _pageBuilder(MemberListPage()));
    router.addRoute(kRouteMemberDetail, _pageBuilder(MemberDetailPage()));

    /// 未ログインでも閲覧可能なパスの一覧はここに追加すること
    router.addFilter(LoginVerificationFilter([
      kRouteLogin,
    ]));

    router.setOnComplete((settings, widget) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widget,
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: anim,
            child: child,
          );
        },
      );
    });

    return router;
  }

  /// ページを返すWidgetBuilderを返す
  static WebRouterWidgetBuilder _pageBuilder(Widget widget) {
    return (request) {
      return Provider<WebRequest>.value(
        value: request,
        child: widget,
      );
    };
  }
}

/// ログイン状態をみるFilter
class LoginVerificationFilter implements WebFilter {
  LoginVerificationFilter(this.exclusionRoutes);

  final List<String> exclusionRoutes;

  final authRepository = AuthRepository();

  @override
  Widget execute(WebFilterChain filterChain) {
    final requestPath = Uri.parse(filterChain.settings.name!).path;

    if (authRepository.isLogin) {
      // ログイン済み

      // 除外されたパスに一致したらルートパスにリダイレクトさせる
      if (_matchExclusion(filterChain, requestPath)) {
        throw RedirectWebRouterException(settings: RouteSettings(name: '/'));
      }

      // 次のFilterへ
      return filterChain.executeNextFilter()!;
    }

    // 未ログイン

    // 除外されたパスなら次のFilterへ
    if (_matchExclusion(filterChain, requestPath)) {
      return filterChain.executeNextFilter()!;
    }

    // ルートパスの場合はログイン画面にリダイレクトさせる
    if (requestPath == '/') {
      throw RedirectWebRouterException(
          settings: RouteSettings(name: kRouteLogin));
    }

    // ページが見つからない
    throw NotFoundWebRouterException();
  }

  /// リクエストパスと除外パスが一致するかを返す
  bool _matchExclusion(WebFilterChain filterChain, String requestPath) {
    for (String route in exclusionRoutes) {
      final request = WebRequest.settings(filterChain.settings, route: route);
      if (request.verify) {
        return true;
      }
    }
    return false;
  }
}
