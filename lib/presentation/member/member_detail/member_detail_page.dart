import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/presentation/default/default_page.dart';
import 'package:eastarrow_web/presentation/member/member_detail/member_detail_model.dart';
import 'package:eastarrow_web/presentation/widgets/date_time_format.dart';
import 'package:eastarrow_web/presentation/widgets/form_container.dart';
import 'package:eastarrow_web/presentation/widgets/form_row.dart';
import 'package:eastarrow_web/presentation/widgets/messages.dart';
import 'package:eastarrow_web/presentation/widgets/page_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:provider/provider.dart';

class MemberDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberDetailModel>(
      create: (context) => MemberDetailModel(context),
      builder: (context, child) {
        return Consumer<MemberDetailModel>(
          builder: (context, model, child) {
            return DefaultPage<MemberDetailModel>(
              route: kRouteMemberDetail,
              children: [
                BootstrapRow(
                  height: 0,
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: PageHeading(
                        title: kTitleMemberDetail,
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Messages(model: model),
                    ),
                    if (model.member != null)
                      BootstrapCol(
                        sizes: 'col-12',
                        child: BootstrapPanel(
                          body: FormContainer(
                            children: [
                              FormRow(
                                label: const Text('名前'),
                                value: (model.member!.name != null)
                                    ? Text(model.member!.name!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('メールアドレス'),
                                value: (model.member!.email != null)
                                    ? Text(model.member!.email!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('誕生日'),
                                value: (model.member!.birthDate != null)
                                    ? Text(model.member!.birthDate!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('住所'),
                                value: (model.member!.location != null)
                                    ? Text(model.member!.location!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('電話番号'),
                                value: (model.member!.phoneNumber != null)
                                    ? Text(model.member!.phoneNumber!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('車種'),
                                value: (model.member!.carType != null)
                                    ? Text(model.member!.carType!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('車検日'),
                                value: (model.member!.inspectionDay != null)
                                    ? Text(model.member!.inspectionDay!)
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('登録日時'),
                                value: (model.member!.createdAt != null)
                                    ? Text(DateTimeFormat()
                                    .formatYMDW(model.member!.createdAt!))
                                    : Text(''),
                              ),
                              FormRow(
                                label: const Text('更新日時'),
                                value: (model.member!.updatedAt != null)
                                    ? Text(DateTimeFormat()
                                    .formatYMDW(model.member!.updatedAt!))
                                    : Text(''),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (model.member != null)
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
                                  child: Text('戻る'),
                                  onPressed: () async {
                                    await model.reopen(kTitleMembersIndex);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: BootstrapButton(
                                  type: BootstrapButtonType.primary,
                                  child: Text('編集'),
                                  onPressed: (){},
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
