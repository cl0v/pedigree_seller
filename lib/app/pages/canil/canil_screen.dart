import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';
import 'package:pedigree_seller/app/models/canil_model.dart';
import 'package:pedigree_seller/app/utils/screen_size.dart';
/*
 - Recebe de um future o canil, caso não esteja cadastrado, aparecerá uma mensagem pedindo para cadastrar
 - Aqui dentro aparecerá a parte de adicionar reprodutores, pets etc...
*/

class CanilController {
  Future<CanilModel?> fetchCanil() async {
    //TODO: Implement fetchCanil
    return null;
  }
}

class CanilScreen extends StatefulWidget {
  @override
  _CanilScreenState createState() => _CanilScreenState();
}

class _CanilScreenState extends State<CanilScreen> {
  final controller = CanilController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldCommonComponents.customAppBarWithoutIcons('Canil'),
      body: FutureBuilder<CanilModel?>(
        future: controller.fetchCanil(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              var canil = snapshot.data;
              return canil != null
                  ? _body(canil)
                  : Center(
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
                    );
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Text('Ocorreu um erro');
          }
        },
      ),
    );
  }


  _body(CanilModel canil) {
  Size size = getSize(context);
    return Container(
      height: size.height,
      width: size.width,

    );
  }
}
