import 'dart:typed_data';

import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/goods.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:eastarrow_web/repository/goods_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_model.dart';

class EditGoodsModel extends BaseModel {
  EditGoodsModel(BuildContext context) : super(context);

  Goods? goods;
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

  @override
  Future<void> init() async {
    try {
      final goodsId = request.data!['goodsId'];
      goods = await goodsRepository.fetchGoods(goodsId!);
      nameController.text = goods!.name!;
      introductionController.text = goods!.introduction!;
      bodyValueController.text = goods!.bodyValue!;
      totalValueController.text = goods!.totalValue!;
      modelYearController.text = goods!.modelYear!;
      mileageController.text = goods!.mileage!;
      inspectionController.text = goods!.inspection!;
      repairController.text = goods!.repair!;
      areaController.text = goods!.area!;
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      notifyListeners();
    }
  }

  /// クリア
  Future<void> clear() async {
    await replace(
      kRouteGoodsEdit,
      data: {
        'goodsId': goods!.id!,
      },
    );
  }

  // お知らせ詳細画面に戻る
  Future<void> reopenView({List<String>? messages}) async {
    await reopen(
      kRouteGoodsDetail,
      data: {
        'goodsId': goods!.id!,
      },
      arguments: messages != null
          ? {
              kArgsMessages: messages,
            }
          : null,
    );
  }

  /// ローカルから選択した画像で更新する
  Future updateImage() async {
    final XFile? data = await picker.pickImage(source: ImageSource.gallery);

    if (data != null) {
      imageData = await data.readAsBytes();
    }

    notifyListeners();
  }

  /// お知らせを追加する
  Future<void> updateGoods() async {
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

      await goodsRepository.updateGoods(goods, imageData);

      /// 詳細画面に戻る
      await reopenView(messages: [
        '更新しました',
      ]);
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      endLoading();
    }
  }
}
