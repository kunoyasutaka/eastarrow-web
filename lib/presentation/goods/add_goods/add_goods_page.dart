import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/presentation/default/default_page.dart';
import 'package:eastarrow_web/presentation/widgets/form_container.dart';
import 'package:eastarrow_web/presentation/widgets/form_item_image.dart';
import 'package:eastarrow_web/presentation/widgets/form_row.dart';
import 'package:eastarrow_web/presentation/widgets/messages.dart';
import 'package:eastarrow_web/presentation/widgets/multi_line_style.dart';
import 'package:eastarrow_web/presentation/widgets/page_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:provider/provider.dart';

import 'add_goods_model.dart';

/// 商品追加ページ
class AddGoodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddGoodsModel>(
      create: (context) => AddGoodsModel(context),
      builder: (context, child) {
        return Consumer<AddGoodsModel>(
          builder: (context, model, child) {
            return DefaultPage<AddGoodsModel>(
              route: kRouteAddGoods,
              children: [
                BootstrapRow(
                  height: 0,
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: PageHeading(
                        title: kTitleNoticesAdd,
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Messages(model: model),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: BootstrapPanel(
                        body: FormContainer(
                          children: [
                            FormRow(
                              label: const Text('商品名'),
                              required: true,
                              value: TextField(
                                controller: model.nameController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('紹介文'),
                              required: true,
                              value: TextField(
                                controller: model.introductionController,
                                decoration: BootstrapInputDecoration(),
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLines: 16,
                                maxLength: 1000,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('本体価格'),
                              required: true,
                              value: TextField(
                                controller: model.bodyValueController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('支払い総額'),
                              required: true,
                              value: TextField(
                                controller: model.totalValueController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('年式'),
                              required: true,
                              value: TextField(
                                controller: model.modelYearController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('走行距離'),
                              required: true,
                              value: TextField(
                                controller: model.mileageController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('車検有無'),
                              required: true,
                              value: TextField(
                                controller: model.inspectionController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('修理歴'),
                              required: true,
                              value: TextField(
                                controller: model.repairController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('地域'),
                              required: true,
                              value: TextField(
                                controller: model.areaController,
                                decoration: BootstrapInputDecoration(),
                                maxLength: 40,
                                maxLines: 1,
                                style: const MultiLineStyle(),
                              ),
                            ),
                            FormRow(
                              label: const Text('画像'),
                              value: Row(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: InkWell(
                                      child: model.imageData == null
                                          ? FormItemImage(
                                              text: 'クリックで画像を設定',
                                            )
                                          : Image.memory(model.imageData!),
                                      onTap: () async {
                                        await model.updateImage();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              child: BootstrapButton(
                                type: BootstrapButtonType.defaults,
                                child: Text('クリア'),
                                onPressed: () async {
                                  await model.clear();
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: BootstrapButton(
                                type: BootstrapButtonType.primary,
                                child: Text('保存'),
                                onPressed: () async {
                                  await model.addGoods();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
