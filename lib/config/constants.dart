import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

/// メニュー名
/// ページを追加したら必ずここにも追加すること
const kTitleLogin = 'ログイン';
const kTitleLogout = 'ログアウト';
const kTitleDashboard = 'ダッシュボード';
const kTitleMembersIndex = '登録者一覧';
const kTitleNotices = 'お知らせ';
const kTitleNoticesIndex = 'お知らせ一覧';
const kTitleNoticesAdd = 'お知らせの追加';
const kTitleGoods = '商品紹介';
const kTitleAddGoods = '商品追加ページ';
const kTitleGoodsList = '商品一覧ページ';
const kTitleGoodsDetail = '商品詳細ページ';
const kTitleGoodsEdit = '商品編集ページ';
const kTitleLoginMemberView = 'ログインメンバー';

/// ルート
/// ページを追加したら必ずここにも追加すること
const kRouteLogin = '/login';
const kRouteLogout = '/logout';
const kRouteDashboard = '/';
const kRouteMembersIndex = '/members';
const kRouteNoticesIndex = '/notices';
const kRouteNoticesAdd = '/notices/add';
const kRouteAddGoods = '/goods/add';
const kRouteGoodsList = '/goods';
const kRouteGoodsDetail = '/goods/view/{goodsId}';
const kRouteGoodsEdit = '/notices/edit/{goodsId}';
const kRouteLoginMemberView = '/loginMember/view';

/// セッション名
const kSessionSortColumnName = 'sortColumnName';
const kSessionSortAscending = 'sortAscending';
const kSessionRowsPerPage = 'rowsPerPage';
const kSessionInitialFirstRowIndex = 'initialFirstRowIndex';
const kSessionFilterText = 'filterText';
const kSessionMemberIcons = 'memberIcons';

/// クエリ名
const kQuerySortColumnName = 'sort';
const kQuerySortAscending = 'asc';
const kQueryRowsPerPage = 'page';
const kQueryInitialFirstRowIndex = 'index';
const kQueryFilterText = 'text';

/// RouteSettingsのarguments名
const kArgsMessages = 'messages';
const kArgsErrorMessages = 'errorMessages';
const kArgsRows = 'rows';
const kArgsClearSession = 'clearSession';

/// グラフ
const kGraphAnimate = true;
const kGraphAnimationDuration = Duration(seconds: 1);

/// グラフデータ名
const kCarType = '車種';

/// CopyRight
const kCopyRight = '(C) 2021 tko-shop';

/// サイドバーメニュー
const kSideBarMenuItems = [
  MenuItem(
    title: kTitleDashboard,
    route: kRouteDashboard,
    icon: Icons.dashboard,
  ),
  MenuItem(
    title: kTitleMembersIndex,
    route: kRouteMembersIndex,
    icon: Icons.group,
  ),
  MenuItem(
    title: kTitleNotices,
    icon: Icons.notifications,
    children: [
      MenuItem(
        title: kTitleNoticesIndex,
        route: kRouteNoticesIndex,
      ),
      MenuItem(
        title: kTitleNoticesAdd,
        route: kRouteNoticesAdd,
      ),
    ],
  ),
  MenuItem(
    title: kTitleGoods,
    icon: Icons.car_repair,
    children: [
      MenuItem(
        title: kTitleGoodsList,
        route: kRouteGoodsList,
      ),
      MenuItem(
        title: kTitleAddGoods,
        route: kRouteAddGoods,
      ),
    ],
  ),
];

/// アクションメニュー
const kActionMenuItems = [
  MenuItem(
    title: kTitleLoginMemberView,
    icon: Icons.admin_panel_settings,
    route: kRouteLoginMemberView,
  ),
  MenuItem(
    title: kTitleLogout,
    icon: Icons.logout,
    route: kRouteLogout,
  ),
];
