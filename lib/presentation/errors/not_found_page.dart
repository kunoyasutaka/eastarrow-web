import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

/// 404 Not Found エラー画面
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BootstrapColors.grayLighter,
      body: BootstrapRow(
        height: 0,
        children: [
          BootstrapCol(
            sizes: 'col-12',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                BootstrapHeading.h1(
                  child: Text('Oops!'),
                ),
                BootstrapHeading.h2(
                  child: Text('404 Not Found'),
                ),
                Text('Sorry, an error has occured, Requested page not found!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
