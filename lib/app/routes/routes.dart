import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/pets/pet_registration/pet_registration_screen.dart';
import 'package:pedigree_seller/app/pages/pets/pets_screen.dart';

abstract class Routes {
  static const Home = '/';
  static const Ninhada = '/ninhada';
  static const Pets = '/pets';
  static const CadastrarPet = '/pets/create';
  static const Categoria = '/category';
}

final routes = 
   <String, WidgetBuilder>{
        Routes.Home: (context)=> HomeScreen(),
        Routes.Ninhada: (context)=> NinhadasScreen(),
        Routes.Pets: (context)=> PetScreen(),
        Routes.CadastrarPet: (context)=> PetRegistrationScreen(),
      }
;
