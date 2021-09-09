import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastarrow_web/domain/goods.dart';
import 'package:logger/logger.dart';

import 'storage_repository.dart';

class GoodsRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionPath = 'goods';
  final _storage = StorageRepository();

  Future<List<Goods>> fetchGoodsList() async {
    try {
      final snapshot = await _db.collection(_collectionPath).get();

      return snapshot.docs.map((e) => Goods.fromFirestore(e)).toList();
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<Goods> fetchGoods(String id) async {
    try {
      final snapshot = await _db.collection(_collectionPath).doc(id).get();
      return Goods.fromFirestore(snapshot);
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<void> addGoods(Goods goods, Uint8List? imageData) async {
    final ref = _db.collection(_collectionPath).doc();
    String imageUrl;

    if (imageData != null) {
      final path = 'goods_image/${ref.id}.png';
      imageUrl = await _storage.uploadImage(
        path,
        imageData,
      );
    } else {
      imageUrl = '';
    }

    await ref.set({
      GoodsField.id: ref.id,
      GoodsField.name: goods.name,
      GoodsField.introduction: goods.introduction,
      GoodsField.imageUrl: imageUrl,
      GoodsField.bodyValue: goods.bodyValue,
      GoodsField.totalValue: goods.totalValue,
      GoodsField.modelYear: goods.modelYear,
      GoodsField.mileage: goods.mileage,
      GoodsField.inspection: goods.inspection,
      GoodsField.repair: goods.repair,
      GoodsField.area: goods.area,
      GoodsField.createdAt: Timestamp.fromDate(DateTime.now()),
      GoodsField.updatedAt: Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteGoods(Goods goods) async {
    await _db.collection(_collectionPath).doc(goods.id).delete();

    if (goods.imageUrl != null) {
      final path = 'goods_image/${goods.id}.png';
      await _storage.deleteImage(path);
    }
  }

  Future<void> updateGoods(Goods goods, Uint8List? imageData) async {
    String imageUrl;

    if (imageData != null) {
      final path = 'goods_image/${goods.id}.png';
      imageUrl = await _storage.uploadImage(
        path,
        imageData,
      );
    } else {
      imageUrl = '';
    }

    await _db.collection(_collectionPath).doc(goods.id).update({
      GoodsField.name: goods.name,
      GoodsField.introduction: goods.introduction,
      GoodsField.imageUrl: imageUrl,
      GoodsField.bodyValue: goods.bodyValue,
      GoodsField.totalValue: goods.totalValue,
      GoodsField.modelYear: goods.modelYear,
      GoodsField.mileage: goods.mileage,
      GoodsField.inspection: goods.inspection,
      GoodsField.repair: goods.repair,
      GoodsField.area: goods.area,
      GoodsField.updatedAt: Timestamp.fromDate(DateTime.now()),
    });
  }
}
