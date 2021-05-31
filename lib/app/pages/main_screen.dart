import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_bloc.dart';
import 'package:pedigree_seller/app/pages/perfil/perfil_screen.dart';
import 'package:pedigree_seller/app/pages/store/store_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import 'canil/canil_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    UserModel.get().then((u) {
      CanilBloc(u!).get().then((c) {
        if (c == null)
          pushNamed(context, Routes.CadastrarCanil);
        else
          setState(() {
            _dataLoaded = true;
            //TODO: Quando eu cadastro, ele volta, porém com uma tela branca estranha
          });
      });
    });
  }

  int pageIndex = 0;

  static const pages = [
    const CanilScreen(),
    const StoreScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final body = _dataLoaded
        ? IndexedStack(
            children: pages,
            index: pageIndex,
          )
        : Center(
            child: CircularProgressIndicator(),
          );

    final bNavBar = _dataLoaded
        ? BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (i) {
              setState(() {
                pageIndex = i;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Loja'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Perfil'),
            ],
          )
        : Container();

    return Scaffold(
      body: body,
      bottomNavigationBar: bNavBar,
    );
  }
}
