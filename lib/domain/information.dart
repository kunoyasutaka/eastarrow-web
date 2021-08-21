import 'package:cloud_firestore/cloud_firestore.dart';

class InformationField {
  static const id = 'id';
  static const classify = 'classify';
  static const title = 'title';
  static const body = 'body';
  static const imageUrl = 'imageUrl';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

class InformationTab {
  static const String all = 'すべて';
  static const String inspection = '車検情報';
  static const String inStock = '入荷情報';
}

class Information {
  final String? id;
  final String? classify;
  final String? title;
  final String? body;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Information({
    this.id,
    this.classify,
    this.title,
    this.body,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Information.fromFirestore(DocumentSnapshot snap) {
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    return Information(
      id: data[InformationField.id] ?? '',
      classify: data[InformationField.classify] ?? '',
      title: data[InformationField.title] ?? '',
      body: data[InformationField.body] ?? '',
      imageUrl: data[InformationField.imageUrl] ?? '',
      createdAt: data[InformationField.createdAt].toDate(),
      updatedAt: data[InformationField.updatedAt].toDate(),
    );
  }
}
