import 'package:flutter/material.dart';

import 'package:pedigree_seller/constants.dart';

class FormErrorText extends StatelessWidget {
  final String errorMsg;
  const FormErrorText(
    this.errorMsg,
  );
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMsg,
      style: kErrorTextStyle,
    );
  }
}
