import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';

class Pedigree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree seller',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Splash,
      routes: routes,
    );
  }
}

class PedigreeDebug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree seller',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Home,
      routes: routes,
    );
  }
}
