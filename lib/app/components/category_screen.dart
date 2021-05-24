import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import '../../constants.dart';

class ValoresCategorias {
  String text;
  List<ValoresCategorias> list;
  ValoresCategorias({
    required this.text,
    this.list = const [],
  });
}

class CategoryScreen extends StatelessWidget {
  final List<ValoresCategorias> valores;
  final String title;
  final Function(String, String) settaValores;

  CategoryScreen({
    required this.title,
    required this.settaValores,
    this.valores = const [],
  });

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.pop(context),
          );
        },
      ),
    );
    var body = ListView.builder(
        itemCount: valores.length,
        itemBuilder: (context, idx) {
          var val = valores[idx];
          return ListTile(
            title: Text(
              val.text,
            ),
            trailing:
                val.list.length > 0 ? Icon(Icons.arrow_forward_ios) : null,
            onTap: () {
              print(val.list);
              if (val.list.length > 0)
                push(
                  context,
                  CategoryScreen(
                    settaValores: settaValores,
                    title: val.text,
                    valores: val.list,
                  ),
                );
              else //TODO: Enviar o valor para a pagina anterior
              //TODO: Enviar o title e o text do val
              {
                settaValores(title, val.text);
                popUntil(context, Routes.CadastrarReprodutor);
                //TODO: Posso passar as parada por aq tb
              }

            },
          );
        });
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
