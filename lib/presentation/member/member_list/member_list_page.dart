import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/member.dart';
import 'package:eastarrow_web/presentation/default/default_page.dart';
import 'package:eastarrow_web/presentation/member/member_list/member_list_model.dart';
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

class MemberListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberListModel>(
      create: (context) => MemberListModel(context),
      builder: (context, child) {
        return Consumer<MemberListModel>(
          builder: (context, model, child) {
            return DefaultPage<MemberListModel>(
              route: kRouteMembersIndex,
              children: [
                BootstrapRow(
                  height: 0,
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: PageHeading(
                        title: kTitleMembersIndex,
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
              ],
            );
          },
        );
      },
    );
  }

  /// 登録者一覧テーブル
  Widget _buildTable(IndexModel model) {
    if (!model.isLoading && model.records.length == 0) {
      // 登録者が0件の場合
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: BootstrapParagraphs(
          child: Text('登録者がいません'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: WebDataTable(
        header: const Text('登録者リスト'),
        source: WebDataTableSource(
          // 並び替え
          sortAscending: model.sortAscending ?? false,
          sortColumnName: model.sortColumnName,

          // 列情報
          columns: [
            WebDataColumn(
              name: 'name',
              label: Text('名前'),
              dataCell: (value) => DataCell(Text('$value')),
            ),
            WebDataColumn(
              name: 'createdAt',
              label: Text('登録日時'),
              dataCell: (value) => DataCell(Text(value)),
              filterText: (value) => value,
            ),
            WebDataColumn(
              name: 'updatedAt',
              label: Text('更新日時'),
              dataCell: (value) => DataCell(Text(value)),
              filterText: (value) => value,
            ),
          ],

          // データ
          rows: model.records.map((r) => _toRow(r)).toList(),

          // 行タップ
          onTapRow: !model.isSelecting
              ? (rows, index) async {
                  // 詳細画面に遷移する
                  ///TODO memberの詳細
                  await model.push(
                    kRouteMemberDetail,
                    data: {
                      'memberId': rows[index]['id'],
                    },
                  );
                }
              : null,

          // テキスト検索
          filterTexts: model.filterTexts,
        ),

        // 並び替え
        onSort: (columnName, ascending) {
          print('onSort(): columnName = $columnName, ascending = $ascending');
          model.updateSortCondition(columnName, ascending);
        },

        // 1ページ毎の表示件数
        // onRowsPerPageChanged: (rowsPerPage) {
        //   print('onRowsPerPageChanged(): rowsPerPage = $rowsPerPage');
        //   model.updateRowsPerPage(rowsPerPage);
        // },
        // rowsPerPage: model.rowsPerPage ?? 1,
        // availableRowsPerPage: model.availableRowsPerPage,
        //
        // // ページ切り替え
        // onPageChanged: (rowIndex) {
        //   print('onPageChanged(): rowIndex = $rowIndex');
        //   model.updateInitialFirstRowIndex(rowIndex);
        // },
        // initialFirstRowIndex: model.initialFirstRowIndex ?? 1,
      ),
    );
  }

  /// 一覧で使う形式に変換する
  Map<String, dynamic> _toRow(Member member) {
    return {
      'id': member.id,
      'name': member.name,
      'email': member.email,
      'birthDate': member.birthDate,
      'location': member.location,
      'phoneNumber': member.phoneNumber,
      'carType': member.carType,
      'inspectionDay': member.inspectionDay,
      'chatTitle': member.chatTitle,
      'createdAt': member.createdAt?.formatYMDW ?? '',
      'updatedAt': member.updatedAt?.formatYMDW ?? '',
    };
  }
}
