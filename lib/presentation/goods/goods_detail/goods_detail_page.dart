import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/presentation/default/default_page.dart';
import 'package:eastarrow_web/presentation/goods/goods_detail/goods_detail_model.dart';
import 'package:eastarrow_web/presentation/widgets/date_time_format.dart';
import 'package:eastarrow_web/presentation/widgets/form_container.dart';
import 'package:eastarrow_web/presentation/widgets/form_item_image.dart';
import 'package:eastarrow_web/presentation/widgets/form_row.dart';
import 'package:eastarrow_web/presentation/widgets/messages.dart';
import 'package:eastarrow_web/presentation/widgets/page_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:provider/provider.dart';

class GoodsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoodsDetailModel>(
      create: (context) => GoodsDetailModel(context),
      builder: (context, child) {
        return Consumer<GoodsDetailModel>(
          builder: (context, model, child) {
            return DefaultPage<GoodsDetailModel>(
              route: kRouteGoodsDetail,
              children: [
                BootstrapRow(
                  height: 0,
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: PageHeading(
                        title: kTitleGoodsDetail,
                        breadcrumbsItems: [
                          BootstrapBreadcrumbsItem(
                            text: kTitleNotices,
                          ),
                          BootstrapBreadcrumbsItem(
                            text: kTitleNoticesIndex,
                            onTap: () async {
                              await model.reopen(kRouteNoticesIndex);
                            },
                          ),
                          BootstrapBreadcrumbsItem(
                            text: kTitleGoodsDetail,
                            active: true,
                          ),
                        ],
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Messages(model: model),
                    ),
                    if (model.goods != null)
                      BootstrapCol(
                        sizes: 'col-12',
                        child: BootstrapPanel(
                          body: FormContainer(
                            children: [
                              FormRow(
                                label: const Text('?????????'),
                                value: (model.goods!.name != null)
                                    ? Text(model.goods!.name!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('????????????'),
                                value: (model.goods!.introduction != null)
                                    ? Text(model.goods!.introduction!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('????????????'),
                                value: (model.goods!.bodyValue != null)
                                    ? Text(model.goods!.bodyValue!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('???????????????'),
                                value: (model.goods!.totalValue != null)
                                    ? Text(model.goods!.totalValue!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('??????'),
                                value: (model.goods!.modelYear != null)
                                    ? Text(model.goods!.modelYear!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('????????????'),
                                value: (model.goods!.mileage != null)
                                    ? Text(model.goods!.mileage!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('????????????'),
                                value: (model.goods!.inspection != null)
                                    ? Text(model.goods!.inspection!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('?????????'),
                                value: (model.goods!.repair != null)
                                    ? Text(model.goods!.repair!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('??????'),
                                value: (model.goods!.area != null)
                                    ? Text(model.goods!.area!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('??????'),
                                value: Row(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: 200,
                                      child:
                                          model.goods!.imageUrl?.isNotEmpty ??
                                                  false
                                              ? Image.network(
                                                  model.goods!.imageUrl![0])
                                              : FormItemImage(),
                                    ),
                                  ],
                                ),
                              ),
                              FormRow(
                                label: const Text('????????????'),
                                value: (model.goods!.createdAt != null)
                                    ? Text(DateTimeFormat()
                                        .formatYMDW(model.goods!.createdAt!))
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('????????????'),
                                value: (model.goods!.updatedAt != null)
                                    ? Text(DateTimeFormat()
                                        .formatYMDW(model.goods!.updatedAt!))
                                    : Text(''),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (model.goods != null)
                      BootstrapCol(
                        sizes: 'col-12',
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: BootstrapButton(
                                  type: BootstrapButtonType.danger,
                                  child: Text('??????'),
                                  onPressed: () async {
                                    await model.deleteGoods();
                                  },
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 100,
                                child: BootstrapButton(
                                  type: BootstrapButtonType.defaults,
                                  child: Text('??????'),
                                  onPressed: () async {
                                    await model.reopen(kTitleGoodsList);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: BootstrapButton(
                                  type: BootstrapButtonType.primary,
                                  child: Text('??????'),
                                  onPressed: () async {
                                    // ???????????????????????????
                                    await model.push(
                                      kRouteGoodsEdit,
                                      data: {
                                        'goodsId': model.goods!.id!,
                                      },
                                    );
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
