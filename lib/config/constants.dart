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
const kTitleLoginMemberView = 'ログインメンバー';

/// ルート
/// ページを追加したら必ずここにも追加すること
const kRouteLogin = '/login';
const kRouteLogout = '/logout';
const kRouteDashboard = '/';
const kRouteMembersIndex = '/members';
const kRouteNoticesIndex = '/notices';
const kRouteNoticesAdd = '/notices/add';
const kRouteLoginMemberView = '/loginMember/view';

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
