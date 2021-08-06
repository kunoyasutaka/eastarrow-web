import 'package:cloud_firestore/cloud_firestore.dart';

class GoodsField {
  static const id = 'id';
  static const name = 'name';
  static const introduction = 'introduction';
  static const imageUrl = 'imageUrl';
  static const bodyValue = 'bodyValue';
  static const totalValue = 'totalValue';
  static const modelYear = 'modelYear';
  static const mileage = 'mileage';
  static const inspection = 'inspection';
  static const repair = 'repair';
  static const area = 'area';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

class Goods {
  final String? id;
  final String? name;
  final String? introduction;
  final List<String>? imageUrl;
  final String? bodyValue;
  final String? totalValue;
  final String? modelYear;
  final String? mileage;
  final String? inspection;
  final String? repair;
  final String? area;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Goods({
    this.id,
    this.name,
    this.introduction,
    this.imageUrl,
    this.bodyValue,
    this.totalValue,
    this.modelYear,
    this.mileage,
    this.inspection,
    this.repair,
    this.area,
    this.createdAt,
    this.updatedAt,
  });

  factory Goods.fromFirestore(DocumentSnapshot snap) {
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    return Goods(
      id: data[GoodsField.id] ?? '',
      name: data[GoodsField.name] ?? '',
      introduction: data[GoodsField.introduction] ?? '',
      imageUrl: List<String>.from(data[GoodsField.imageUrl] ?? []),
      bodyValue: data[GoodsField.bodyValue] ?? '',
      totalValue: data[GoodsField.totalValue] ?? '',
      modelYear: data[GoodsField.modelYear] ?? '',
      mileage: data[GoodsField.mileage] ?? '',
      inspection: data[GoodsField.inspection] ?? '',
      repair: data[GoodsField.repair] ?? '',
      area: data[GoodsField.area] ?? '',
      createdAt: data[GoodsField.createdAt].toDate(),
      updatedAt: data[GoodsField.updatedAt].toDate(),
    );
  }
}
