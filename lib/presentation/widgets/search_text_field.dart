import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

import 'multi_line_style.dart';

/// 検索用のテキストフィールド
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    this.width = 400,
    required this.controller,
    this.hitText = '',
  }) : super(key: key);

  final double width;
  final TextEditingController controller;
  final String hitText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width,
          height: 50,
          color: Colors.white,
          child: TextField(
            controller: controller,
            decoration: BootstrapInputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: hitText,
            ),
            style: MultiLineStyle(),
          ),
        ),
      ],
    );
  }
}
