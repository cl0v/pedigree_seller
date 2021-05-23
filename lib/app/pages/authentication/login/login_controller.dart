import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_api.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import 'enums/login_state_enum.dart';

class LoginController {
//TODO: Refazer isso, ta uma porcaria

  LoginController({required this.context});
  BuildContext context;

  final TextEditingController emailController =
      TextEditingController(text: 'marcelofv12@hotmail.com');
  final TextEditingController senhaController =
      TextEditingController(text: '123456789');

  bool confirmed = false;
  bool emailPreenchido = false;
  bool senhaPreenchido = false;

  final controller = StreamController();
  StreamSink get streamInput => controller.sink;
  Stream get output => controller.stream;

  close() {
    controller.close();
  }

  _login() async {
    var val = await LoginApi.login(emailController.text, senhaController.text);
    if (val != null) {
      streamInput.add(LoginState.Confirmed);
      pushNamed(context, Routes.Home, replace: true);
    } else {
      streamInput.addError(val);
      streamInput.add(LoginState.Error);
    }
  }

  onRegisterPressed() {
    pushNamed(context, Routes.Register, replace: true);
  }

  verifyLogin() {
    confirmed = true;
    emailPreenchido = emailController.text != '';
    senhaPreenchido = senhaController.text != '';

    if (!(emailPreenchido && senhaPreenchido))
      return streamInput.add(LoginState.Error);

    streamInput.add(LoginState.Loading);
    _login();
  }
}
