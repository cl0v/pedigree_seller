import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';
import 'package:pedigree_seller/app/pages/login/login_screen.dart';
import 'package:pedigree_seller/app/pages/store_home/store_home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree seller',
      debugShowCheckedModeBanner: false,
      home: StoreHomeScreen(),
    );
  }
}
