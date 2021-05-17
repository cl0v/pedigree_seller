import 'package:flutter/material.dart';
import 'app/pages/store_home/store_pet_parents_registration_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree seller',
      debugShowCheckedModeBanner: false,
      home: StorePetParentsRegistration(),
    );
  }
}
