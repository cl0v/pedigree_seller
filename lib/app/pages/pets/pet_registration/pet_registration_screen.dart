import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/models/raca_model.dart';
import 'package:pedigree_seller/app/models/reprodutores_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/constants.dart';

//TODO: Recriar a pagina para deixar bem claro como vai ficar na hora de adicionar(Quadrado grandao pra enviar foto, setinha pra botar nome, etc)
//TODO: Permitir que a página que cria é a mesma que edita
//(Essa pode ser a página de triagem, para preencher os dados rapidos(Especie, titulo e categoria, macho femea etc))
//TODO: Implement controller of petRegistration

///Cadastrar os cachorros reprodutores (Pai e Mae)
///Para agilizar o cadastro da ninhada
///


class PetRegistrationController {
  Raca? _categoria; //TODO:Mudar para pegar especie e categoria
  var _isMacho = false;
  var _nome = '';

  set nomeSetter(String s) => _nome = s;

  get categoriaSelecionada => _categoria!.especie;
  set categoria(Raca c) => _categoria = c;
  get isMachoGetter => _isMacho;
  set isMachoSetter(bool b) => _isMacho = b;

  Future onRegisterPressed(context) async {
    ReprodutoresModel reprodutoresModel = ReprodutoresModel(
      nome: _nome,
      categoria: _categoria!,
      isMacho: !_isMacho,
    );
    print(reprodutoresModel);
    back(context, reprodutoresModel);

    // PetModel Criar AnimalModel com as configs
  }
}


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

  final controller = PetRegistrationController();

  String title = 'Selecione a categoria';

  update() {
    setState(() {
      title = controller.categoriaSelecionada;
    });
  }

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
            onPressed: () async {
              await controller.onRegisterPressed(context);
              //Implementar StreamButtonWidget aqui
            },
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        children: [
          ImagePickerTileWidget(
            title: 'Foto',
            // fileSetter: fileSetter,
          ),
          TextFormField(
            onChanged: (val) {
              controller.nomeSetter = val;
            },
            decoration: InputDecoration(
              hintText: 'Nome',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),

          //TODO: Criar uma bordinha pra ficar file
          ListTile(
            //TODO: Tentar colocar em forma de widget reutilizavel
            title: Text(title),
            subtitle: Text('*Selecione a categoria'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              push(context,
                  CategoryScreen(controller: controller, onUpdate: update));
            },
          ),
          ListTile(
            title: Text(!controller.isMachoGetter ? 'Macho' : 'Fêmea'),
            subtitle: Text('*Selecione o gênero'),
            trailing: Switch(
              value: controller.isMachoGetter,
              onChanged: (val) {
                setState(() {
                  controller.isMachoSetter = val;
                });
              },
              activeColor: Colors.red,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.blue,
              inactiveThumbColor: Colors.blue,
            ),
            onTap: () {
              setState(() {
                _maleFemale = !_maleFemale;
              });
            },
          ),
          ImagePickerTileWidget(
            title: 'Certificado de Pedigree',
            // fileSetter: fileSetter,
          )
        ],
      ),
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
