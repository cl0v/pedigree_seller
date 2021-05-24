import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/reprodutores/cadastrar_reprodutores_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import '../../constants.dart';

class CategoryScreen extends StatelessWidget {
  final PetRegistrationController controller;
  final VoidCallback onUpdate;
  final int stepCount;

  CategoryScreen({
    Key? key,
    required this.controller,
    required this.onUpdate,
    this.stepCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = controller.fetchCategoryStringList(stepCount);
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
            if (stepCount == 0) {
              controller.categoria = list[idx];
              push(
                context,
                CategoryScreen(
                  controller: controller,
                  onUpdate: onUpdate,
                  stepCount: stepCount + 1,
                ),
              );
            } else {
              controller.especie = list[idx];
              popUntil(context, Routes.CadastrarReprodutor);
            }
            onUpdate.call();
          },
        ),
      ),
    );
  }
}
