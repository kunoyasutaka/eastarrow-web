import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

import 'multi_line_style.dart';

/// 1行のForm部品
/// レスポンシブに対応している
class FormRow extends StatelessWidget {
  final Widget label;
  final Widget value;
  final bool required;

  FormRow({
    Key? key,
    required this.label,
    required this.value,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BootstrapRow(
        height: 0,
        children: [
          BootstrapCol(
            sizes: 'col-sm-12',
            invisibleForSizes: 'md lg xl',
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                BootstrapLabelText(
                  child: DefaultTextStyle.merge(
                    style: MultiLineStyle(),
                    child: label,
                  ),
                ),
                if (required)
                  BootstrapLabel(
                    text: '必須',
                    type: BootstrapLabelType.danger,
                  ),
              ],
            ),
          ),
          BootstrapCol(
            sizes: 'col-md-3',
            invisibleForSizes: 'xs sm',
            child: Container(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BootstrapLabelText(
                    child: DefaultTextStyle.merge(
                      style: MultiLineStyle(),
                      child: label,
                    ),
                  ),
                  if (required)
                    BootstrapLabel(
                      text: '必須',
                      type: BootstrapLabelType.danger,
                    ),
                ],
              ),
            ),
          ),
          BootstrapCol(
            sizes: 'col-sm-12 col-md-9',
            child: value,
          ),
        ],
      ),
    );
  }
}
