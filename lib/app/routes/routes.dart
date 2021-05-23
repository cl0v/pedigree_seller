import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/splash/splash_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_screen.dart';
import 'package:pedigree_seller/app/pages/canil/canil_screen.dart';
import 'package:pedigree_seller/app/pages/canil/create_canil_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_screen.dart';
import 'package:pedigree_seller/app/pages/perfil/perfil_screen.dart';

abstract class Routes {
  static const Splash = '/';
  static const Home = '/home';
  static const Login = '/login';
  static const Register = '/register';
  static const Ninhada = '/ninhada';
  static const Reprodutores = '/reprodutores';
  static const CadastrarReprodutor = '/reprodutores/cadastrar';
  static const Canil = '/canil';
  static const CadastrarCanil = '/canil/cadastrar';
  static const Perfil = '/perfil';
  // static const Categoria = '/category';
}

final routes = <String, WidgetBuilder>{
  //TODO: Troquei a home com canil pra facilitar
  Routes.Home: (context) => CanilScreen(),
  Routes.Login: (context) => LoginScreen(),
  Routes.Register: (context) => RegisterScreen(),
  Routes.Ninhada: (context) => NinhadasScreen(),
  Routes.Reprodutores: (context) => ReprodutoresScreen(),
  Routes.CadastrarReprodutor: (context) => CadastrarReprodutoresScreen(),
  Routes.CadastrarCanil: (context) => CreateCanilScreen(),
  Routes.Canil: (context) => CanilScreen(),
  Routes.Perfil: (context) => PerfilScreen(),
  Routes.Splash: (context) => SplashScreen(),
};
