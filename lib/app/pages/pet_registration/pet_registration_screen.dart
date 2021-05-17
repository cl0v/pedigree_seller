import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/constants.dart';

class PetRegistrationFormModel {
  String name;
  bool isMale;
  //Especie
  //Categoria
  String category;
  String specie;
  File image;
  File pedigreeCertification;
  PetRegistrationFormModel({
    required this.name,
    required this.isMale,
    required this.category,
    required this.specie,
    required this.image,
    required this.pedigreeCertification,
  });
}

List<String> petCategories = [
  'Gato',
  'Cachorro',
  'Coelho',
  'Hamster',
];

List<String> petSpecies = [
  'Rotwailer',
  'Cachorro',
  'Coelho',
  'Hamster',
];

class PetRegistrationScreen extends StatefulWidget {
  @override
  _PetRegistrationScreenState createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {
  File? file;

  fileSetter(File f) {
    file = f;
  }

  bool _maleFemale = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _body(),
      appBar: _appBar(),
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
            title: 'Cadastrar',
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StorePetParentsRegistration(),
              //   ),
              // );
            },
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Nome',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),
        ),
        ImagePickerTileWidget(
          title: 'Foto',
          fileSetter: fileSetter,
        ),
        //Selecionar categoria
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selecione a categoria:'),
              DropdownButton(
                  onChanged: (val) {},
                  items: petCategories
                      .map((cat) => DropdownMenuItem(
                            child: Text(cat),
                            value: cat,
                          ))
                      .toList())
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selecione a especie:'),
              DropdownButton(
                  onChanged: (val) {},
                  items: petSpecies
                      .map((cat) => DropdownMenuItem(
                            child: Text(cat),
                            value: cat,
                          ))
                      .toList())
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selecione o sexo:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Macho'),
                  Switch(
                    value: _maleFemale,
                    onChanged: (val) {
                      setState(() {
                        _maleFemale = val;
                      });
                    },
                    activeColor: Colors.red,
                    activeTrackColor: Colors.red,
                    inactiveTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.blue,
                  ),
                  Text('Femea')
                ],
              ),
            ],
          ),
        ),

        //Selecionar sexo

        //TODO: Sexo
        //TODO: Selecionar a raça por aqui facilitaria muito a criação da ninhada
        ImagePickerTileWidget(
          title: 'Certificado de Pedigree',
          fileSetter: fileSetter,
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Registrar',
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
    );
  }
}
