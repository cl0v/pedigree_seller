import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/stream_button_widget.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_screen.dart';

enum LoginState {
  Idle,
  Loading,
  Confirmed,
  Error,
}

class LoginController {
  StreamController controller = StreamController();
  StreamSink get streamInput => controller.sink;
  Stream get output => controller.stream;

  login() async {
    streamInput.add(LoginState.Loading);
    await Future.delayed(Duration(seconds: 2));
    streamInput.add(LoginState.Error);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextInputFieldWidget(
                  hint: 'Email',
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                ),
                TextInputFieldWidget(
                  hint: 'Password',
                  icon: Icons.lock,
                  isObscure: true,
                  inputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: 25,
                ),
                loginBtn(),
                SizedBox(
                  height: 25,
                ),
              ],
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
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          state: LoginState.Idle),
      StateButtonOptions(
        child: Theme(
          data: ThemeData().copyWith(accentColor: Colors.white),
          child: CircularProgressIndicator(),
        ),
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
      state: stateList,
      onPressed: controller.login,
    );
  }
}
