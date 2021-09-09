import 'package:eastarrow_web/config/admin_colors.dart';
import 'package:eastarrow_web/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:provider/provider.dart';

import '../base_model.dart';
import 'default_model.dart';

/// ログイン後の共通画面
/// このクラスを使えば良い感じに3ペインの画面が作れます
class DefaultPage<M extends BaseModel> extends StatelessWidget {
  final List<Widget> children;
  final String route;

  DefaultPage({
    Key? key,
    required this.route,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DefaultModel>(
      create: (context) => DefaultModel(context),
      builder: (context, child) {
        final childModel = context.watch<M>();
        final model = context.watch<DefaultModel>();
        return LayoutBuilder(
          builder: (context, constraints) {
            return AdminScaffold(
              backgroundColor: AdminColors.bodyBackground,
              appBar: AppBar(
                title: const Text('管理画面'),
                actions: _buildActions(model),
              ),
              sideBar: SideBar(
                backgroundColor: AdminColors.sideBarBackground,
                activeBackgroundColor: AdminColors.sideBarActiveBackground,
                borderColor: AdminColors.sideBarBorder,
                textStyle: TextStyle(
                  color: AdminColors.sideBarText,
                  fontSize: 13,
                ),
                activeTextStyle: TextStyle(
                  color: AdminColors.sideBarText,
                  fontSize: 13,
                ),
                items: kSideBarMenuItems,
                selectedRoute: route,
                onSelected: (item) => model.onSelectedSidebarMenu(item, route),
                footer: InkWell(
                  child: Container(
                    width: double.infinity,
                    color: AdminColors.sideBarFooterBackground,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          kCopyRight,
                          style: TextStyle(
                            fontSize: 10,
                            color: AdminColors.sideBarFooterText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    model.showAdminAboutDialog();
                  },
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: BootstrapContainer(
                      fluid: true,
                      children: children,
                    ),
                  ),
                  childModel.isLoading
                      ? Container(
                          color: Colors.black.withOpacity(0.1),
                          height: constraints.maxHeight,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// アクションメニュー
  List<Widget> _buildActions(DefaultModel model) {
    return [
      PopupMenuButton(
        child: Icon(
          Icons.account_circle,
          size: 36,
        ),
        itemBuilder: (context) {
          return kActionMenuItems.map((MenuItem item) {
            return PopupMenuItem<MenuItem>(
              value: item,
              child: Row(
                children: [
                  Icon(item.icon, color: AdminColors.themeBlack),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      item.title,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
        onSelected: (MenuItem? item) => model.onSelectedActionMenu(item),
      ),
      SizedBox(width: 10),
    ];
  }
}
