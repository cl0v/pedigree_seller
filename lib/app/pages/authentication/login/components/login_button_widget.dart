import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/stream_button_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/login/enums/login_state_enum.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key, this.onPressed, this.stream}) : super(key: key);

  final onPressed;
  final stream;
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

  @override
  Widget build(BuildContext context) {
    return StreamButtonWidget(
      stream: stream,
      initialState: LoginState.Idle,
      states: stateList,
      onPressed: onPressed,
    );
  }
}
