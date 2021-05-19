import 'package:flutter/material.dart';
import 'package:pedigree_seller/app.dart';
import 'package:firebase_core/firebase_core.dart';

//TODO: Use modelos e variaveis em ptBr, vai evitar perder tempo pensando em ing

//TODO: Fazer a splash screen do pedigree (logo) ser uma hero com a loginscreen



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
