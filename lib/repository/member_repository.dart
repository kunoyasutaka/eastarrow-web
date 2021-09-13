import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastarrow_web/domain/member.dart';
import 'package:logger/logger.dart';

class MemberRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionPath = 'member';

  Future<List<Member>> fetchMemberList() async {
    try {
      final snapshot = await _db.collection(_collectionPath).get();

      return snapshot.docs.map((e) => Member.fromFirestore(e)).toList();
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<Member> fetchMember(String id) async {
    try {
      final snapshot = await _db.collection(_collectionPath).doc(id).get();
      return Member.fromFirestore(snapshot);
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }
}
