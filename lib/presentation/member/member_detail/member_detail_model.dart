import 'package:eastarrow_web/domain/member.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:eastarrow_web/repository/member_repository.dart';
import 'package:flutter/material.dart';

import '../../base_model.dart';

class MemberDetailModel extends BaseModel {
  MemberDetailModel(BuildContext context) : super(context);

  final repository = MemberRepository();
  Member? member;

  @override
  Future init() async {
    try {
      // データを取得する
      // 必ずIDを受け取って画面遷移してくるためnullは入らない
      final String memberId = request.data!['memberId']!;
      member = await repository.fetchMember(memberId);
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      notifyListeners();
    }
  }
}
