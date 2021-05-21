import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';

/*
 - Recebe de um future o canil, caso não esteja cadastrado, aparecerá uma mensagem pedindo para cadastrar
 - Aqui dentro aparecerá a parte de adicionar reprodutores, pets etc...
*/

class CanilScreen extends StatefulWidget {
  @override
  _CanilScreenState createState() => _CanilScreenState();
}

class _CanilScreenState extends State<CanilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldCommonComponents.customAppBarWithoutIcons('Canil'),
      body: Center(
        child: RichText(
          text: TextSpan(
            style: kBodyTextStyle,
            children: [
              TextSpan(
                text: 'Você não criou uma loja ainda\n',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Clique aqui para criar',
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