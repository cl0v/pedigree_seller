import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/models/reprodutores_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/constants.dart';

//TODO: Implement PetController

class ReprodutoresScreen extends StatefulWidget {
  @override
  _ReprodutoresScreenState createState() => _ReprodutoresScreenState();
}

class _ReprodutoresScreenState extends State<ReprodutoresScreen> {
  List<ReprodutorModel> petList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.1,
            0,
            size.width * 0.1,
            8,
          ),
          child: CustomButtonWidget(
            title: 'Cadastrar um Pet',
            onPressed: () async {
              ReprodutorModel? valor =
                  await pushNamed(context, Routes.CadastrarPet);
              if (valor != null)
                setState(() {
                  petList.add(valor);
                });
            },
          ),
        ),
      ),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Meus pets',
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
        itemCount: petList.length,
        itemBuilder: (context, index) {
          var pet = petList[index];
          return ListTile(
            // leading: Icon(Icons.mars),
            trailing: IconButton(
              icon: Icon(Icons.adaptive.more),
              onPressed: () {
                //TODO: OnTap para editar
                //Mostrar um popupmenubutton com as opçoes de editar, deletar, (Add arquivar), etc;
              },
            ),
            subtitle: Text(pet.categoria.especie!),
            title: Text(pet.nome),
          );
        },
      ),
    );
  }
}
