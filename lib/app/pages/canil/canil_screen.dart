import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_bloc.dart';
import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';
import 'package:pedigree_seller/app/utils/screen_size.dart';
/*
 - Aqui dentro aparecerá a parte de adicionar reprodutores, pets etc...
*/

//TODO: Quando voltar pra ca, ele precisa updatar automaticamente('Ou solicitar o aguardo da aprovação, sei la')

class CanilScreen extends StatefulWidget {
  @override
  _CanilScreenState createState() => _CanilScreenState();
}

class _CanilScreenState extends State<CanilScreen> {
  final _bloc = CanilBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.canil.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _bloc.fetchCanil();
    _bloc.sub();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);

    var appBar = ScaffoldCommonComponents.customAppBarWithDrawerAndAction(
        'Canil', Icons.refresh, () {
      _bloc.fetchCanil();
    });
    var drawer = CustomDrawer();

    var noData = Center(
      child: RichText(
        text: TextSpan(
          style: kBodyTextStyle,
          children: [
            TextSpan(
              text: 'Você não criou uma loja ainda\n',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Clique aqui para criar\n\n\n',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () => pushNamed(context, Routes.CadastrarCanil),
            ),
            TextSpan(
              text: 'Se ja criou, atualize a página',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _bloc.fetchCanil(),
            ),
          ],
        ),
      ),
    );

    var error = Center(child: Text('Ocorreu um erro'));

    var loading = Center(
      child: CircularProgressIndicator(),
    );

    var body = StreamBuilder<CanilModel?>(
        stream: _bloc.canil.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              var canil = snapshot.data;
              if (canil != null) {
                return Container(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: Text(canil.titulo),
                  ),
                );
              }
              return noData;
            case ConnectionState.waiting:
              return loading;
            case ConnectionState.done:
              var canil = snapshot.data;
              if (canil == null)
                return noData;
              else
                return Container(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: Text(canil.titulo),
                  ),
                );
            default:
              return error;
          }
        });

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: body,
    );
  }
}
