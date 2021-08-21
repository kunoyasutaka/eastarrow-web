import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/goods.dart';
import 'package:eastarrow_web/presentation/default/default_page.dart';
import 'package:eastarrow_web/presentation/widgets/messages.dart';
import 'package:eastarrow_web/presentation/widgets/page_heading.dart';
import 'package:eastarrow_web/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:provider/provider.dart';
import 'package:eastarrow_web/extension/date_time.dart';

import '../../index_model.dart';
import 'goods_list_model.dart';

class GoodsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoodsListModel>(
      create: (context) => GoodsListModel(context),
      builder: (context, child) {
        return Consumer<GoodsListModel>(
          builder: (context, model, child) {
            return DefaultPage<GoodsListModel>(
              route: kRouteGoodsList,
              children: [
                BootstrapRow(
                  height: 0,
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: PageHeading(
                        title: kTitleGoodsList,
                        breadcrumbsItems: [
                          BootstrapBreadcrumbsItem(
                            text: kTitleNotices,
                          ),
                          BootstrapBreadcrumbsItem(
                            text: kTitleNoticesIndex,
                            active: true,
                          ),
                        ],
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Messages(model: model),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SearchTextField(
                          controller: model.filterTextController,
                          hitText: 'Find a notification...',
                        ),
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: _buildTable(model),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () async {
                        await model.push(kRouteAddGoods);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// お知らせ一覧テーブル
  Widget _buildTable(IndexModel model) {
    if (!model.isLoading && model.records.length == 0) {
      // お知らせが0件の場合
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: BootstrapParagraphs(
          child: Text('お知らせは登録されていません'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: WebDataTable(
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: BootstrapButton(
                type: BootstrapButtonType.defaults,
                child: Text(model.isSelecting ? '解除' : '選択'),
                onPressed: () {
                  model.toggleSelecting();
                },
              ),
            ),
            if (model.isSelecting)
              BootstrapButton(
                type: BootstrapButtonType.danger,
                child: Text('一括削除'),
                onPressed: model.selectedRowKeys.isNotEmpty
                    ? () async {
                        await model.deleteSelected();
                      }
                    : null,
              ),
          ],
        ),
        source: WebDataTableSource(
          // 並び替え
          sortAscending: model.sortAscending ?? false,
          sortColumnName: model.sortColumnName,

          // 列情報
          columns: [
            WebDataColumn(
              name: 'imageUrl',
              label: Text(''),
              dataCell: (value) => DataCell(
                CircleAvatar(
                  backgroundColor:
                      value == '' ? Colors.grey.withOpacity(0.5) : Colors.white,
                  backgroundImage: value == '' ? null : NetworkImage(value),
                ),
              ),
              sortable: false,
            ),
            WebDataColumn(
              name: 'name',
              label: Text('商品名'),
              dataCell: (value) => DataCell(Text('$value')),
            ),
            WebDataColumn(
              name: 'createdAt',
              label: Text('作成日時'),
              dataCell: (value) =>
                  DataCell(Text((value as DateTime).formatYMDW)),
              filterText: (value) => (value as DateTime).formatYMDW,
            ),
            WebDataColumn(
              name: 'updatedAt',
              label: Text('更新日時'),
              dataCell: (value) =>
                  DataCell(Text((value as DateTime).formatYMDW)),
              filterText: (value) => (value as DateTime).formatYMDW,
            ),
          ],

          // データ
          rows: model.records.map((r) => _toRow(r)).toList(),

          // 行タップ
          onTapRow: !model.isSelecting
              ? (rows, index) async {
                  // 詳細画面に遷移する
                  await model.push(
                    kRouteGoodsView,
                    data: {
                      'goodsId': rows[index]['id'],
                    },
                  );
                }
              : null,
          // 一括削除
          onSelectRows: model.isSelecting
              ? (keys) {
                  print('onSelectRows(): keys = $keys');
                  model.updateSelectedRowKeys(keys);
                }
              : null,
          selectedRowKeys: model.selectedRowKeys,
          primaryKeyName: model.primaryKey,

          // テキスト検索
          filterTexts: model.filterTexts,
        ),

        // 並び替え
        onSort: (columnName, ascending) {
          print('onSort(): columnName = $columnName, ascending = $ascending');
          model.updateSortCondition(columnName, ascending);
        },

        // 1ページ毎の表示件数
        onRowsPerPageChanged: (rowsPerPage) {
          print('onRowsPerPageChanged(): rowsPerPage = $rowsPerPage');
          model.updateRowsPerPage(rowsPerPage);
        },
        rowsPerPage: model.rowsPerPage ?? 1,
        availableRowsPerPage: model.availableRowsPerPage,

        // ページ切り替え
        onPageChanged: (rowIndex) {
          print('onPageChanged(): rowIndex = $rowIndex');
          model.updateInitialFirstRowIndex(rowIndex);
        },
        initialFirstRowIndex: model.initialFirstRowIndex ?? 1,
      ),
    );
  }

  /// 一覧で使う形式に変換する
  Map<String, dynamic> _toRow(Goods goods) {
    return {
      'id': goods.id,
      'name': goods.name,
      'introduction': goods.introduction,
      'imageUrl': goods.imageUrl![0], // 一覧表示用に1つ目の画像を選択
      'bodyValue': goods.bodyValue,
      'totalValue': goods.totalValue,
      'modelYear': goods.modelYear,
      'mileage': goods.mileage,
      'inspection': goods.inspection,
      'repair': goods.repair,
      'area': goods.area,
      'createdAt': goods.createdAt,
      'updatedAt': goods.updatedAt,
    };
  }
}
