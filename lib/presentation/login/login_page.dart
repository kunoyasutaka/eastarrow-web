import 'package:eastarrow_web/config/admin_colors.dart';
import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/presentation/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel(context),
      child: Scaffold(
        backgroundColor: AdminColors.bodyBackground,
        body: Consumer<LoginModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                BootstrapContainer(
                  fluid: true,
                  children: [
                    BootstrapRow(
                      height: 0,
                      children: [
                        BootstrapCol(
                          sizes: 'col-md-12 col-xl-6',
                          offsets: 'offset-md-0 offset-xl-3',
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: BootstrapPanel(
                              header: const BootstrapHeading.h4(
                                child: Text('サロン管理Webアプリ'),
                                marginTop: 5,
                                marginBottom: 5,
                              ),
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BootstrapHeading.h5(
                                    child: Text(kTitleLogin),
                                    marginTop: 0,
                                  ),
                                  Messages(model: model),
                                  BootstrapFormGroup(
                                    children: [
                                      TextField(
                                        controller: model.emailController,
                                        decoration: BootstrapInputDecoration(
                                          hintText: 'email',
                                        ),
                                      ),
                                    ],
                                  ),
                                  BootstrapFormGroup(
                                    children: [
                                      TextField(
                                        controller: model.passwordController,
                                        obscureText: model.passwordObscure,
                                        decoration: BootstrapInputDecoration(
                                          hintText: 'password',
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              model.togglePasswordObscure();
                                            },
                                            child: Icon(Icons.remove_red_eye),
                                          ),
                                        ),
                                        onEditingComplete: () async {
                                          await model.login();
                                        },
                                      ),
                                    ],
                                  ),
                                  BootstrapParagraphs(
                                    child: BootstrapButton(
                                      type: BootstrapButtonType.success,
                                      size: BootstrapButtonSize.large,
                                      child: Text('ログイン'),
                                      onPressed: () async {
                                        await model.login();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                model.isLoading
                    ? Container(
                        color: Colors.black.withOpacity(0.2),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
