import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/domain/user_role.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:eastarrow_web/exception/validator_exception.dart';
import 'package:eastarrow_web/repository/auth_repository.dart';
import 'package:eastarrow_web/repository/login_member_repository.dart';
import 'package:flutter/material.dart';

import '../base_model.dart';

class LoginModel extends BaseModel {
  LoginModel(BuildContext context) : super(context);

  final _authRepository = AuthRepository();
  final _loginMemberRepository = LoginMemberRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordObscure = true;

  /// ログインする
  Future login() async {
    startLoading();
    try {
      // ログインする
      await _authRepository.login(
          emailController.text, passwordController.text);

      // ログインメンバー情報を取得しロールが管理者でなければエラーにする
      final loginMember = await _loginMemberRepository.fetch();
      if (loginMember!.role != UserRole.admin) {
        await _authRepository.logout();
        throw ValidatorException(errorMessages: ['管理者ではありません']);
      }

      // ログイン成功したのでトップページに遷移する
      await reopen(kRouteDashboard);
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      endLoading();
    }
  }

  /// ログアウトする
  Future logout() async {
    try {
      await _authRepository.logout();
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    }
  }

  /// パスワードを隠すかどうかを切り替える
  void togglePasswordObscure() {
    passwordObscure = !passwordObscure;
    notifyListeners();
  }
}
