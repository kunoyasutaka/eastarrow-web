import 'dart:typed_data';

import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/goods.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:eastarrow_web/repository/goods_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_model.dart';

class AddGoodsModel extends BaseModel {
  AddGoodsModel(BuildContext context) : super(context);

  final goodsRepository = GoodsRepository();
  final nameController = TextEditingController();
  final introductionController = TextEditingController();
  final bodyValueController = TextEditingController();
  final totalValueController = TextEditingController();
  final modelYearController = TextEditingController();
  final mileageController = TextEditingController();
  final inspectionController = TextEditingController();
  final repairController = TextEditingController();
  final areaController = TextEditingController();

  /// 画像データ
  Uint8List? imageData;
  final picker = ImagePicker();

  /// ローカルから選択した画像で更新する
  Future updateImage() async {
    final XFile? data = await picker.pickImage(source: ImageSource.gallery);

    if (data != null) {
      imageData = await data.readAsBytes();
    }

    notifyListeners();
  }

  /// クリア
  Future clear() async {
    await replace(kRouteAddGoods);
  }

  /// お知らせを追加する
  Future addGoods() async {
    startLoading();
    try {
      Goods goods = Goods(
        name: nameController.text.trim(),
        introduction: introductionController.text.trim(),
        bodyValue: bodyValueController.text.trim(),
        totalValue: totalValueController.text.trim(),
        modelYear: modelYearController.text.trim(),
        mileage: mileageController.text.trim(),
        inspection: inspectionController.text.trim(),
        repair: repairController.text.trim(),
        area: areaController.text.trim(),
      );

      await goodsRepository.addGoods(goods, imageData);

      /// 一覧画面に遷移する
      push(
        kRouteGoodsList,
        arguments: {
          kArgsMessages: [
            '追加しました',
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
