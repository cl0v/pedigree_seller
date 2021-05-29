import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import '../../constants.dart';

class CategoriasEspecies {
  String text;
  List<CategoriasEspecies> list;
  CategoriasEspecies({
    required this.text,
    this.list = const [],
  });
}



class CategorySelectorScreen extends StatelessWidget {
  final List<CategoriasEspecies> valores;
  final String title;
  final Function(String, String) onValuesChanged;
  final String route;

  CategorySelectorScreen({
    required this.title,
    required this.onValuesChanged,
    required this.route,
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
              if (val.list.length > 0)
                push(
                  context,
                  CategorySelectorScreen(
                    onValuesChanged: onValuesChanged,
                    title: val.text,
                    valores: val.list,
                    route: route,
                  ),
                );
              else {
                onValuesChanged(title, val.text);
                popUntil(context, route);
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
