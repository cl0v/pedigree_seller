import 'package:flutter/material.dart';

import 'package:pedigree_seller/app/models/pet_model.dart';

import '../../../../constants.dart';

class ItemTile {
  String titulo;
  bool hasSub;
  ItemTile({
    required this.titulo,
    required this.hasSub,
  });
}

class Configs {
  String? category;
  String? especie;
  Configs({
    this.category,
    this.especie,
  });
}

class CategoryController {
  final list = petCategories;

  Future<List> fetchConfigs(Configs configs) async {
    return [];
  }
}

class CategoryScreen extends StatefulWidget {
  final Configs? configs;

  // final onConfigsIs

  CategoryScreen({
    this.configs,
  });

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final controller = CategoryController();

  criaConfigsEProcuraEspecie() {}

  retornaComEspecie() {}

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
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.pop(context),
          );
        }),
      ),
      body: CustomListViewWidget(controller: controller),
    );
  }
}

class CustomListViewWidget extends StatelessWidget {
  final controller;

  CustomListViewWidget(
      {Key? key, required this.controller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.list.length,
      itemBuilder: (context, idx) => ListTile(
        title: Text(
          controller.list[idx],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
        },
      ),
    );
  }
}
