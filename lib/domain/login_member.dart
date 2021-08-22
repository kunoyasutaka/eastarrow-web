import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastarrow_web/domain/user_role.dart';

class LoginMemberField {
  static const id = 'id';
  static const name = 'name';
  static const role = 'role';
}

class LoginMember {
  /// ID
  final String? id;

  /// ネーム
  final String? name;

  /// ロール
  final UserRole? role;

  LoginMember({
    this.id,
    this.name,
    this.role,
  });

  factory LoginMember.fromFirestore(DocumentSnapshot snap) {
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return LoginMember(
      id: snap.id,
      name: data[LoginMemberField.name] ?? '',
      role: UserRoleHelper.valueOf(data[LoginMemberField.role]),
    );
  }
}
