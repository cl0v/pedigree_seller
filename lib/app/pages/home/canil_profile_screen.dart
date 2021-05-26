import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class CanilProfileScreen extends StatefulWidget {
  @override
  _CanilProfileScreenState createState() => _CanilProfileScreenState();
}

class _CanilProfileScreenState extends State<CanilProfileScreen> {
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
                  ListTile(
                    title: Text('Contato:'),
                    subtitle: Text(
                      canil.contato,
                    ),
                  ),
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
    var drawer = CustomDrawer();

    var result = Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: fBuilder,
    );

    return result;
  }
}
