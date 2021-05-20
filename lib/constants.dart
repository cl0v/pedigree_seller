import 'package:flutter/material.dart';

const String errorMsg = 'Campo obrigatório';
Text errorText = Text(
  errorMsg,
  style: kErrorTextStyle,
);

TextStyle kBodyTextStyle = TextStyle();
TextStyle kTitleTextStyle = TextStyle(
  color: Colors.black,
);
TextStyle kErrorTextStyle = TextStyle(
    color: Colors.red[700], fontWeight: FontWeight.w400, fontSize: 12);
