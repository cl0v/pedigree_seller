import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var future = UserModel.get();

    var fBuilder = FutureBuilder<UserModel?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return UserAccountsDrawerHeader(
            accountName: Text(snapshot.data!.nome),
            accountEmail: Text(snapshot.data!.email),
            // currentAccountPicture: ,
          );
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );

    var children = [
      fBuilder,
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
          //TODO: Implement onTap
        },
      ),
      ListTile(
        title: Text('Sair'),
        leading: Icon(Icons.exit_to_app),
        onTap: () {
          UserModel.clear();
          pushNamed(context, Routes.Login, replace: true);

          // Vendedor.clear();
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
