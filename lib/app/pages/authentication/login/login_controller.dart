import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import 'enums/login_state_enum.dart';

class LoginController {
  LoginController({required this.context});
  BuildContext context;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

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
    await Future.delayed(Duration(seconds: 2));
    //TODO: Connect login
    streamInput.add(LoginState.Confirmed);
    pushNamed(context, Routes.Home);
  }

  onRegisterPressed() {
    pushNamed(context, Routes.Register);
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
