import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/login_member.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:eastarrow_web/repository/auth_repository.dart';
import 'package:eastarrow_web/repository/login_member_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../base_model.dart';

class DefaultModel extends BaseModel {
  DefaultModel(BuildContext context) : super(context);

  final _authRepository = AuthRepository();
  final _loginMemberRepository = LoginMemberRepository();

  LoginMember? loginMember;

  @override
  Future init() async {
    try {
      loginMember = await _loginMemberRepository.fetch();
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      notifyListeners();
    }
  }

  /// サイドバーメニューが選択された
  Future onSelectedSidebarMenu(MenuItem item, String route) async {
    print('sideBar: onSelected(): route = ${item.route}');
    if (item.route != null) {
      await reopen(
        item.route!,
        arguments: {
          // セッションをクリアする
          kArgsClearSession: true,
        },
      );
    }
  }

  /// アクションメニューが選択された
  Future<void> onSelectedActionMenu(MenuItem? item) async {
    if (item != null) {
      switch (item.route) {
        // ログインメンバー表示ページ
        case kRouteLoginMemberView:
          await push(kRouteLoginMemberView);
          break;

        // ログアウト
        case kRouteLogout:
          if (await showConfirmDialog(message: 'ログアウトしますか？')) {
            try {
              await _authRepository.logout();
              await reopen(kRouteLogin);
            } on ApplicationException catch (e) {
              errorMessages.clear();
              errorMessages.addAll(e.errorMessages);
            }
          }
          break;
      }
    }
  }
}
