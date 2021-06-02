
import 'package:flutter/material.dart';

import 'package:pedigree_seller/app/utils/nav.dart';

import '../../constants.dart';

class Categoria {
  late String categoria;
  late List<String> especies;

  Categoria({
    required this.categoria,
    required this.especies,
  });


  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      categoria: map['categoria'],
      especies:  map['especies'],
    );
  }

}
//TODO: Remover
class CategoriasEspecies {
  String text;
  List<CategoriasEspecies> list;
  CategoriasEspecies({
    required this.text,
    this.list = const [],
  });
}

class CategorySelectorScreen extends StatelessWidget {
  final List<CategoriasEspecies> categorias;
  final List<Categoria> c;
  final List<String>? especies;
  final String title;
  final Function(String, String) onChanged;
  final String routeBack;

  CategorySelectorScreen({
    required this.title,
    required this.onChanged,
    required this.routeBack,
    this.c = const [],
    this.categorias = const [],
    this.especies = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<String> list = especies ?? c.map((c) => c.categoria).toList();

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
        itemCount: list.length,
        itemBuilder: (context, idx) {
          final txt = list[idx];
          return ListTile(
            title: Text(
              txt,
            ),
            trailing: especies == null ? Icon(Icons.arrow_forward_ios) : null,
            onTap: () {
              if (especies == null) {
                push(
                    context,
                    CategorySelectorScreen(
                      title: c[idx].categoria,
                      onChanged: onChanged,
                      routeBack: routeBack,
                      especies: c[idx].especies

                    ));
              }

              // if (val.list.length > 0)
              //   push(
              //     context,
              //     CategorySelectorScreen(
              //       onChanged: onChanged,
              //       title: val.text,
              //       categorias: val.list,
              //       routeBack: routeBack,
              //     ),
              //   );
              else {
                onChanged(title, txt);
                popUntil(context, routeBack);
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
