import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/splash/splash_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_screen.dart';
import 'package:pedigree_seller/app/pages/canil/create_canil_screen.dart';
import 'package:pedigree_seller/app/pages/home/canil_profile_screen.dart';
import 'package:pedigree_seller/app/pages/main_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/cadastrar_ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_screen.dart';
import 'package:pedigree_seller/app/pages/perfil/perfil_screen.dart';

abstract class Routes {
  static const Splash = 'splash'; //TODO: Corrigir para voltar a funcionar com /
  static const Home = '/';
  static const Login = 'login';
  static const Register = 'login/create';
  static const Ninhada = '/ninhada';
  static const CadastrarNinhada = '/ninhada/create';
  static const Reprodutores = '/reprodutores';
  static const CadastrarReprodutor = '/reprodutores/create';
  static const CanilInfo = '/canil/info';
  static const CadastrarCanil = '/canil/create';
  static const Perfil = '/perfil';
  // static const Categoria = '/category';
}

final routes = <String, WidgetBuilder>{
  //TODO: Troquei a home com canil pra facilitar
  Routes.CanilInfo: (context) => CanilInfoScreen(),
  Routes.CadastrarNinhada: (context) => CadastrarNinhadaScreen(),
  Routes.Login: (context) => LoginScreen(),
  Routes.Register: (context) => RegisterScreen(),
  Routes.Ninhada: (context) => NinhadasScreen(),
  Routes.Reprodutores: (context) => ReprodutoresScreen(),
  Routes.CadastrarReprodutor: (context) => CadastrarReprodutoresScreen(),
  Routes.CadastrarCanil: (context) => CreateCanilScreen(),
  Routes.Home: (context) => MainScreen(),
  Routes.Perfil: (context) => PerfilScreen(),
  Routes.Splash: (context) => SplashScreen(),
};
