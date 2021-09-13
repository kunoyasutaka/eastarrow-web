import 'package:eastarrow_web/domain/goods.dart';
import 'package:eastarrow_web/repository/goods_repository.dart';
import 'package:flutter/material.dart';

import '../../index_model.dart';

class MemberListModel extends IndexModel {
  MemberListModel(BuildContext context)
      : super(
    context,
    sortColumnName: 'createdAt',
    sortAscending: false,
    primaryKey: 'id',
    recordDisplayName: '商品紹介',
  );

  final repository = GoodsRepository();

  @override
  Future<List<Goods>> fetchAll() async {
    return await repository.fetchGoodsList();
  }

  @override
  Future delete(record) async {
    await repository.deleteGoods(record);
  }

  @override
  void find(String key) {
    return records.where((r) => r.id == key).first;
  }
}
