import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/pets/pets_screen.dart';

import 'app/pages/ninhada/components/category_screen.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree seller',
      debugShowCheckedModeBanner: false,
      // home: CategoryScreen(),
      initialRoute: '/category',
      routes: <String, WidgetBuilder>{
        '/': (context)=> HomeScreen(),
        '/ninhada' : (context)=> NinhadasScreen(),
        '/pets' : (context)=> PetScreen(),
        '/category' : (context)=> CategoryScreen(),
      },
    );
  }
}
