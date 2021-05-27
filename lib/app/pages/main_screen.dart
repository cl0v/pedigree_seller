import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/perfil/perfil_screen.dart';
import 'package:pedigree_seller/app/pages/store/store_screen.dart';

import 'canil/canil_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 1;
  List<Widget> pages = [
    CanilScreen(),
    StoreScreen(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: pages, index: pageIndex,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (i) {
          setState(() {
            pageIndex = i;
          });
        },
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Loja'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
