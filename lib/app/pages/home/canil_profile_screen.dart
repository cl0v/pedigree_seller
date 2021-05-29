import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class CanilInfoScreen extends StatefulWidget {
  @override
  _CanilInfoScreenState createState() => _CanilInfoScreenState();
}

class _CanilInfoScreenState extends State<CanilInfoScreen> {
  var future = CanilModel.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fBuilder = FutureBuilder<CanilModel?>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            CanilModel? canil = snapshot.data;
            if (canil != null)
              return ListView(
                
                children: [
                  ListTile(
                    title: Text('Titulo:'),
                    subtitle: Text(
                      canil.titulo,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Contato:'),
                    subtitle: Text(
                      canil.contato,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('CNPJ:'),
                    subtitle: Text(
                      '${canil.cnpj.substring(0, 3)}*...*******',
                    ),
                  ),
                ],
              );
            else
              return Center(
                child: Text('Nenhum canil cadastrado'),
              );
          default:
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var appBar = ScaffoldCommonComponents.customAppBar('Loja', () {
      pop(context);
    });

    var result = Scaffold(
      appBar: appBar,
      // drawer: drawer,
      body: fBuilder,
    );

    return result;
  }
}
