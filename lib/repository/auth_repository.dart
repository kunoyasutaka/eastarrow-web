import 'package:eastarrow_web/exception/generic_exception.dart';
import 'package:eastarrow_web/exception/validator_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ユーザ認証
class AuthRepository {
  final _auth = FirebaseAuth.instance;

  /// ログイン中Firebaseユーザを返す
  User? get firebaseUser => _auth.currentUser;

  /// ログイン中かどうかを返す
  bool get isLogin => _auth.currentUser != null;

  /// ログインする
  Future<void> login(String email, String password) async {
    List<String> errorMessages = [];
    if (email.isEmpty) {
      errorMessages.add('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      errorMessages.add('パスワードを入力してください');
    }
    if (errorMessages.isNotEmpty) {
      throw ValidatorException(errorMessages: errorMessages);
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      throw ValidatorException(errorMessages: [_toErrorMessage(e)]);
    } catch (e) {
      throw GenericException(errorMessages: [e.toString()]);
    }
  }

  /// ログアウトする
  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw GenericException(errorMessages: [e.toString()]);
    }
  }

  /// エラーメッセージに変換する
  String _toErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'メールアドレスを正しい形式で入力してください';
      case 'wrong-password':
        return 'パスワードが間違っています';
      case 'user-not-found':
        return 'ユーザーが見つかりません';
      case 'user-disabled':
        return 'ユーザーが無効です';
      case 'too-many-requests':
        return 'ログインに失敗しました。しばらく経ってから再度お試しください';
      case 'operation-not-allowed':
        return 'ログインが許可されていません。管理者にご連絡ください';
      default:
        return '不明なエラーです';
    }
  }
}
