import 'package:eastarrow_web/config/admin_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

/// ページタイトル
class PageHeading extends StatelessWidget {
  const PageHeading({
    Key? key,
    this.title = '',
    this.breadcrumbsItems = const [],
  }) : super(key: key);

  final String title;
  final List<BootstrapBreadcrumbsItem> breadcrumbsItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BootstrapHeading.h3(
              child: Text(title),
              marginBottom: 0,
            ),
            Flexible(
              flex: 1,
              child: BootstrapBreadcrumbs(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                fontSize: 12,
                children: breadcrumbsItems,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: AdminColors.headingBorder,
            thickness: 1.4,
          ),
        ),
      ],
    );
  }
}
