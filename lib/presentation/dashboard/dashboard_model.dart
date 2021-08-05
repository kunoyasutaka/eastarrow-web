import 'package:eastarrow_web/domain/user.dart';
import 'package:flutter/material.dart';

import '../base_model.dart';

class DashboardModel extends BaseModel {
  DashboardModel(BuildContext context) : super(context);

  List<User> members = [];
}
