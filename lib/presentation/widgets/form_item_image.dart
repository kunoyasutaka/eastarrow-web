import 'package:flutter/material.dart';

/// FormItem 画像選択
class FormItemImage extends StatelessWidget {
  final IconData icon;
  final String text;

  FormItemImage({
    Key? key,
    this.icon = Icons.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blueGrey.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
