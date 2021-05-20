import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedigree_seller/app/components/stream_button_widget.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/constants.dart';

enum LoginState {
  Idle,
  Loading,
  Confirmed,
  Error,
}

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  bool confirmed = false;
  bool emailPreenchido = false;
  bool senhaPreenchido = false;

  StreamController controller = StreamController();
  StreamSink get streamInput => controller.sink;
  Stream get output => controller.stream;

  login(context) async {
    confirmed = true;
    emailPreenchido = emailController.text != '';
    senhaPreenchido = senhaController.text != '';

    if (!(emailPreenchido && senhaPreenchido)) return;

    streamInput.add(LoginState.Loading);
    await Future.delayed(Duration(seconds: 2));
    streamInput.add(LoginState.Confirmed);
    pushNamed(context, Routes.Home);

    //TODO: Implement onLoginPressed
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = LoginController();
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
                // crossAxisAlignment: CrossAxisAlignment.,
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
                  loginBtn(),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
                );
              },
              child: Container(
                child: Text(
                  'Cadastrar-se',
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                ))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  StreamButtonWidget loginBtn() {
    final stateList = [
      StateButtonOptions(
          child: Text(
            'Entrar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          state: LoginState.Idle),
      StateButtonOptions(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
        // child: Icon(Icons.add, color: Colors.white,),
        state: LoginState.Loading,
      ),
      StateButtonOptions(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 32,
          ),
          state: LoginState.Confirmed,
          buttonColor: Colors.green),
      StateButtonOptions(
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 32,
          ),
          state: LoginState.Error,
          buttonColor: Colors.red),
    ];
    return StreamButtonWidget(
      stream: controller.output,
      initialState: LoginState.Idle,
      states: stateList,
      onPressed: () {
        setState(() {
          controller.login(context);
        });
      },
    );
  }
}
