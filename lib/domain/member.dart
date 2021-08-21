import 'package:cloud_firestore/cloud_firestore.dart';

class MemberField {
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const birthDate = 'birthDate';
  static const location = 'location';
  static const phoneNumber = 'phoneNumber';
  static const carType = 'carType';
  static const inspectionDay = 'inspectionDay';
  static const chatTitle = 'chatTitle';

  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

class Member {
  final String? id;
  final String? name;
  final String? email;
  final String? birthDate;
  final String? location;
  final String? phoneNumber;
  final String? carType;
  final String? inspectionDay;
  final List<Map>? chatTitle;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Member({
    this.id,
    this.name,
    this.email,
    this.birthDate,
    this.location,
    this.phoneNumber,
    this.carType,
    this.inspectionDay,
    this.chatTitle,
    this.createdAt,
    this.updatedAt,
  });

  factory Member.fromFirestore(DocumentSnapshot snap) {
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    return Member(
      id: data[MemberField.id] ?? '',
      name: data[MemberField.name] ?? '',
      email: data[MemberField.email] ?? '',
      birthDate: data[MemberField.birthDate] ?? '',
      location: data[MemberField.location] ?? '',
      phoneNumber: data[MemberField.phoneNumber] ?? '',
      carType: data[MemberField.carType] ?? '',
      inspectionDay: data[MemberField.inspectionDay] ?? '',
      chatTitle: List<Map>.from(data[MemberField.chatTitle] ?? []),
      createdAt: data[MemberField.createdAt].toDate(),
      updatedAt: data[MemberField.updatedAt].toDate(),
    );
  }
}

class ChatTitleField {
  static const docId = 'docId';
  static const title = 'title';
}
