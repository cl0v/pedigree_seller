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

  final controller = StreamController()..sink.close();
  StreamSink get streamInput => controller.sink;
  Stream get output => controller.stream;

  _login() async {
    await Future.delayed(Duration(seconds: 2));
    //TODO: Connect login
  }

  onRegisterPressed() {
    pushNamed(context, Routes.Register);
  }

  verifyLogin() async {
    confirmed = true;
    emailPreenchido = emailController.text != '';
    senhaPreenchido = senhaController.text != '';

    if (!(emailPreenchido && senhaPreenchido)) return;

    streamInput.add(LoginState.Loading);
    await _login();
    streamInput.add(LoginState.Confirmed);
    pushNamed(context, Routes.Home);
  }
}
