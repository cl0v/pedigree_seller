import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Header'),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
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
              //TODO: Create StorePage
              //TODO: Implement onTap
            },
          ),
          ListTile(
            title: Text('Perfil'),
            leading: Icon(Icons.person),
            onTap: () {
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
        ],
      ),
    );
  }
}
