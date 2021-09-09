import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'form_row.dart';

/// Form部品のまとまり
class FormContainer extends StatelessWidget {
  FormContainer({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<FormRow> children;

  @override
  Widget build(BuildContext context) {
    return BootstrapContainer(
      fluid: true,
      children: children,
    );
  }
}
