import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class CanilRegisterScreen extends StatefulWidget {
  @override
  _CanilRegisterScreenState createState() => _CanilRegisterScreenState();
}

class _CanilRegisterScreenState extends State<CanilRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: ScaffoldCommonComponents.customAppBar(
        'Cadastrar',
        () => pop(context),
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 48),
            children: [
              TextSpan(
                text: 'This is not a link, ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'but this is',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    pushNamed(context, Routes.CadastrarCanil);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
