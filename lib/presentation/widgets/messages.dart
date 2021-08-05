import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

import '../base_model.dart';

/// エラーメッセージを表示するアラート
class Messages extends StatelessWidget {
  final BaseModel model;

  const Messages({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.messages.isEmpty && model.errorMessages.isEmpty) {
      return SizedBox();
    }

    List<Widget> children = [];
    if (model.messages != null) {
      for (String message in model.messages) {
        children.add(
          BootstrapAlert(
            type: BootstrapAlertType.success,
            child: Expanded(child: Text(message)),
            dismissble: true,
          ),
        );
      }
    }
    if (model.errorMessages != null) {
      for (String message in model.errorMessages) {
        children.add(
          BootstrapAlert(
            type: BootstrapAlertType.danger,
            child: Expanded(child: Text('【エラー】 $message')),
          ),
        );
      }
    }
    return Column(
      children: children,
    );
  }
}
