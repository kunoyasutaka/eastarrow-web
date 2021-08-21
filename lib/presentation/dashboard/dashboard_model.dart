import 'package:eastarrow_web/domain/member.dart';
import 'package:flutter/material.dart';

import '../base_model.dart';

class DashboardModel extends BaseModel {
  DashboardModel(BuildContext context) : super(context);

  List<Member> members = [];
}
