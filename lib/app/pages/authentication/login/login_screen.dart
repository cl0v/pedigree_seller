import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_controller.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/constants.dart';

import 'components/login_button_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  @override
  void initState() {
    super.initState();
    controller = LoginController(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Center(
                child: Text(
                  'Pedigree',
                  style: TextStyle(
                    color: Colors.red.withOpacity(.8),
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  TextInputFieldWidget(
                    hint: 'Email',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    controller: controller.emailController,
                  ),
                  controller.confirmed && !controller.emailPreenchido
                      ? errorText
                      : Container(),
                  TextInputFieldWidget(
                    hint: 'Senha',
                    icon: Icons.lock,
                    isObscure: true,
                    inputAction: TextInputAction.done,
                    controller: controller.senhaController,
                  ),
                  controller.confirmed && !controller.senhaPreenchido
                      ? errorText
                      : Container(),
                  SizedBox(
                    height: 25,
                  ),
                  LoginButton(
                    onPressed: () {
                      setState(() {
                        controller.verifyLogin();
                      });
                    },
                    stream: controller.output,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            Center(
              child: RichText(
                  text: TextSpan(
                text: 'Criar conta',
                style: kBodyTextStyle.copyWith(
                    fontSize: 16, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = controller.onRegisterPressed,
              )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
