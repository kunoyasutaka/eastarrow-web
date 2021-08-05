class LoginMember {
  /// ID
  final String? id;

  /// 名前
  final String? name;

  /// 写真画像URL
  final String? photoUrl;

  /// 入会日時
  final DateTime? createDtime;

  /// 更新日時
  final DateTime? modifyDtime;

  LoginMember(
      {this.id, this.name, this.photoUrl, this.createDtime, this.modifyDtime});
}
