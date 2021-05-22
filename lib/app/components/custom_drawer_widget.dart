import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

//TODO: Corrigir bug de rotas

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var children = [
      DrawerHeader(
        child: Text('Header'),
      ),
      ListTile(
        title: Text('Home'),
        leading: Icon(Icons.home),
        onTap: () {
          popUntil(context, Routes.Home);
        },
      ),
      ListTile(
        title: Text('Reprodutores'),
        leading: Icon(Icons.dashboard),
        onTap: () {
          //O que acontece se ja tiver na tela?
          pushNamed(context, Routes.Reprodutores);
        },
      ),
      ListTile(
        title: Text('Ninhadas'),
        leading: Icon(Icons.dashboard),
        onTap: () {
          pushNamed(context, Routes.Ninhada);
        },
      ),
      ListTile(
        title: Text('Canil'),
        leading: Icon(Icons.store),
        onTap: () {
          pushNamed(context, Routes.Canil);
          //TODO: Implement onTap
        },
      ),
      ListTile(
        title: Text('Perfil'),
        leading: Icon(Icons.person),
        onTap: () {
          pushNamed(context, Routes.Perfil);
          //TODO: Create PerfilPage
          //TODO: Implement onTap
        },
      ),
      ListTile(
        title: Text('Sair'),
        leading: Icon(Icons.exit_to_app),
        onTap: () {
          //TODO: Implement exit
        },
      ),
    ];

    var result = Drawer(
      child: ListView(
        children: children,
      ),
    );

    return result;
  }
}
