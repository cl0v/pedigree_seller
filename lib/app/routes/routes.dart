import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_screen.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_screen.dart';

abstract class Routes {
  static const Home = '/home';
  static const Login = '/';
  static const Register = '/register';
  static const Ninhada = '/ninhada';
  static const Reprodutores = '/reprodutores';
  static const CadastrarReprodutor = '/reprodutores/create';
  // static const Categoria = '/category';
}

final routes = <String, WidgetBuilder>{
  Routes.Home: (context) => HomeScreen(),
  Routes.Login: (context) => LoginScreen(),
  Routes.Register: (context) => RegisterScreen(),
  Routes.Ninhada: (context) => NinhadasScreen(),
  Routes.Reprodutores: (context) => ReprodutoresScreen(),
  Routes.CadastrarReprodutor: (context) => CadastrarReprodutoresScreen(),
};
