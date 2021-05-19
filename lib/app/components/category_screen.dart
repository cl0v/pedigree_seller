import 'package:flutter/material.dart';

import 'package:pedigree_seller/app/models/pet_model.dart';
import 'package:pedigree_seller/app/models/raca_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import '../../constants.dart';


class CategoryScreen extends StatelessWidget {
  final Raca? configs;
  final PetRegistrationController controller;
  final VoidCallback? onUpdate;

  final list = petCategories;

  CategoryScreen({Key? key, this.configs, required this.controller, this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Categorias',
          style: kTitleTextStyle,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey[800],
              ),
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, idx) => ListTile(
          title: Text(
            list[idx],
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            if (configs == null) {
              Raca c = Raca(category: list[idx]);
              push(
                  context,
                  CategoryScreen(
                    configs: c,
                    controller: controller,
                    onUpdate: onUpdate,
                  ));
            } else {
              configs!.especie = list[idx];
              controller.categoria = configs!;
              onUpdate!.call();
              // controller.categoriaSelecionada = list[idx];
              //retorna para a página anterior a primeira categoryScreen

              Navigator.popUntil(context, ModalRoute.withName('/pets/create'));
            }
          },
        ),
      ),
    );
  }
}
