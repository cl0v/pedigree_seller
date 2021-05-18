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



class CategoryScreen extends StatelessWidget {
  final list = petCategories;

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
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, idx) => ListTile(
          title: Text(
            list[idx],
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }
}
