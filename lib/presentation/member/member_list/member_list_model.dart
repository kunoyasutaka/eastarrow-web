import 'package:eastarrow_web/domain/member.dart';
import 'package:eastarrow_web/repository/member_repository.dart';
import 'package:flutter/material.dart';

import '../../index_model.dart';

class MemberListModel extends IndexModel {
  MemberListModel(BuildContext context)
      : super(
    context,
    sortColumnName: 'createdAt',
    sortAscending: false,
    primaryKey: 'id',
    recordDisplayName: '登録者情報',
  );

  final repository = MemberRepository();

  @override
  Future<List<Member>> fetchAll() async {
    return await repository.fetchMemberList();
  }

  @override
  Future delete(record) async {}

  @override
  void find(String key) {
    return records.where((r) => r.id == key).first;
  }
}
