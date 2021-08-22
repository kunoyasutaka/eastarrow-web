import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastarrow_web/domain/login_member.dart';
import 'package:eastarrow_web/exception/generic_exception.dart';
import 'package:eastarrow_web/repository/auth_repository.dart';

class LoginMemberRepository {
  final _authRepository = AuthRepository();
  final _db = FirebaseFirestore.instance;
  final _collectionPath = 'users';

  /// ログインメンバー情報（ここで保持することでメモリキャッシュしている）
  LoginMember? _loginMember;

  /// 管理者を返す
  /// 一度取得したらメモリキャッシュしておく
  Future<LoginMember?> fetch() async {
    if (_loginMember == null) {
      final id = _authRepository.firebaseUser?.uid;
      if (id == null) {
        throw GenericException(errorMessages: ['ログインしていません']);
      }
      final doc = await _db.collection(_collectionPath).doc(id).get();
      if (!doc.exists) {
        throw GenericException(errorMessages: ['管理者が見つかりませんでした']);
      }
      _loginMember = LoginMember.fromFirestore(doc);
    }
    return _loginMember;
  }
}
