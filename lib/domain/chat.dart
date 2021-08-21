import 'package:cloud_firestore/cloud_firestore.dart';

class ChatField {
  static const docId = 'id';
  static const userId = 'userId';
  static const userName = 'userName';
  static const title = 'title';
  static const chatDetail = 'chatDetail';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

class Chat {
  final String? docId; //ChatTitle.docIdを代入
  final String? userId; //User.userIdを代入
  final String? userName; //User.nameを代入
  final String? title;
  final List<Map>? chatDetail;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Chat({
    this.docId,
    this.userId,
    this.userName,
    this.title,
    this.chatDetail,
    this.createdAt,
    this.updatedAt,
  });

  ///DBのchatのdocを入れるとChat型で返す
  factory Chat.fromFirestore(DocumentSnapshot snap) {
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    return Chat(
      docId: data[ChatField.docId] ?? '',
      userId: data[ChatField.userId] ?? '',
      userName: data[ChatField.userName] ?? '',
      title: data[ChatField.title] ?? '',
      chatDetail: List<Map>.from(data[ChatField.chatDetail] ?? []),
      createdAt: data[ChatField.createdAt].toDate(),
      updatedAt: data[ChatField.updatedAt].toDate(),
    );
  }
}
