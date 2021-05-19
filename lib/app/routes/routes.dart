import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_screen.dart';

abstract class Routes {
  static const Home = '/';
  static const Ninhada = '/ninhada';
  static const Reprodutores = '/pets';
  static const CadastrarPet = '/pets/create';
  static const Categoria = '/category';
}

final routes = <String, WidgetBuilder>{
  Routes.Home: (context) => HomeScreen(),
  Routes.Ninhada: (context) => NinhadasScreen(),
  Routes.Reprodutores: (context) => ReprodutoresScreen(),
  Routes.CadastrarPet: (context) => CadastrarReprodutoresScreen(),
};
