import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

/// ロール
enum UserRole {
  /// サロンメンバー
  member,

  /// 管理者
  admin,
}

extension UserRoleHelper on UserRole {
  static const labels = {
    UserRole.member: 'メンバー',
    UserRole.admin: '管理者',
  };

  static const tags = {
    UserRole.member: 0,
    UserRole.admin: 1,
  };
  static const rawValues = {
    UserRole.member: 'member',
    UserRole.admin: 'admin',
  };

  static const labelTypes = {
    UserRole.member: BootstrapLabelType.info,
    UserRole.admin: BootstrapLabelType.danger,
  };

  String? get label => labels[this];
  int? get tag => tags[this];
  String? get rawValue => rawValues[this];
  BootstrapLabelType? get labelType => labelTypes[this];

  static UserRole valueOf(String value) => UserRole.values
      .firstWhere((e) => e.rawValue == value, orElse: () => UserRole.member);
}
