import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree seller',
      debugShowCheckedModeBanner: false,
      // home: CategoryScreen(),
      initialRoute: Routes.Register,
      routes: routes,
    );
  }
}
