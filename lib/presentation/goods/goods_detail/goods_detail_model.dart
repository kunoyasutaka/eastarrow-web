import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/goods.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:eastarrow_web/repository/goods_repository.dart';
import 'package:flutter/material.dart';

import '../../base_model.dart';

class GoodsDetailModel extends BaseModel {
  GoodsDetailModel(BuildContext context) : super(context);

  final repository = GoodsRepository();
  Goods? goods;

  @override
  Future init() async {
    try {
      // データを取得する
      // 必ずIDを受け取って画面遷移してくるためnullは入らない
      final String goodsId = request.data!['goodsId']!;
      goods = await repository.fetchGoods(goodsId);
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      notifyListeners();
    }
  }

  /// お知らせを削除する
  Future deleteGoods() async {
    if (!await showConfirmDialog(message: '削除しますか？')) {
      return;
    }

    startLoading();
    try {
      if (goods != null) {
        await repository.deleteGoods(goods!);
      }
      // 一覧画面に遷移する
      reopen(
        kRouteGoodsList,
        arguments: {
          kArgsMessages: [
            '削除しました',
          ],
        },
      );
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      endLoading();
    }
  }
}
