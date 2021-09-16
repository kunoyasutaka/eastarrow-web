import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/presentation/default/default_page.dart';
import 'package:eastarrow_web/presentation/widgets/messages.dart';
import 'package:eastarrow_web/presentation/widgets/page_heading.dart';
import 'package:eastarrow_web/presentation/widgets/panel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:provider/provider.dart';

import 'dashboard_model.dart';

/// ダッシュボード
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardModel>(
      create: (context) => DashboardModel(context),
      builder: (context, child) {
        return Consumer<DashboardModel>(
          builder: (context, model, child) {
            return DefaultPage<DashboardModel>(
              route: kRouteDashboard,
              children: [
                BootstrapRow(
                  height: 0,
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: PageHeading(
                        title: kTitleDashboard,
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Messages(model: model),
                    ),
                  ],
                ),
                // if (model.version != null)
                //   BootstrapRow(
                //     height: 0,
                //     children: [
                //       BootstrapCol(
                //           sizes: 'col-12',
                //           child: Card(
                //             child: Container(
                //               height: 88,
                //               padding: EdgeInsets.all(8),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'review_version',
                //                     style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   Text(model.version),
                //                   Spacer(),
                //                   ElevatedButton(
                //                     onPressed: () async {
                //                       await model.editReviewVersion();
                //                     },
                //                     child: Text('編集する'),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           )),
                //     ],
                //   ),
                if (model.members != null)
                  BootstrapRow(
                    height: 0,
                    children: [
                      BootstrapCol(
                        sizes: 'col-sm-12 col-lg-6 col-xl-3',
                        child: PanelCard(
                          type: BootstrapPanelType.primary,
                          icon: Icons.group,
                          number: model.members.length,
                          description: '登録者数',
                          onTap: () async {
                            await model.push(
                              kRouteMembersIndex,
                              queryParameters: {
                                kQueryFilterText: '',
                              },
                            );
                          },
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-sm-12 col-lg-6 col-xl-3',
                        child: PanelCard(
                          type: BootstrapPanelType.yellow,
                          icon: Icons.group,
                          //TODO 仮の数字
                          number: 10,
                          description: '登録者数',
                          onTap: () async {
                            await model.push(
                              kRouteMembersIndex,
                              queryParameters: {
                                kQueryFilterText: '',
                              },
                            );
                          },
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12',
                        child: BootstrapPanel(
                          header: Text('プラン毎の在籍月数'),
                          body: SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: //ElapsedGraph(members: model.members),
                                Text('test'),
                          ),
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-md-12 col-lg-6',
                        child: BootstrapPanel(
                          header: Text('拠点'),
                          body: SizedBox(
                            width: double.infinity,
                            height: 300,
                            //TODO
                            child: //PrefectureGraph(members: model.members),
                                Text('test'),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
