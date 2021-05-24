//TODO: Recriar a pagina para deixar bem claro como vai ficar na hora de adicionar(Quadrado grandao pra enviar foto, setinha pra botar nome, etc)
//TODO: Permitir que a página que cria é a mesma que edita

import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_bloc.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/alert.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

import '../../../constants.dart';

///Página de triagem, para facilitar o preenchimento dos dados mais comuns(Especie, titulo e categoria, macho femea etc))
///Cadastrar os animais reprodutores (Pai e Mae)
///Para agilizar o cadastro da ninhada
///

class PetRegistrationController {
  bool isMacho = true;
  String nome = 'Reprodutor';
  String? isRequired;

  String categoria = '';
  String especie = '';
}

List<ValoresCategorias> listaDeValores = [
  ValoresCategorias(text: 'Cachorro', list: [
    ValoresCategorias(text: 'Rotwailer'),
    ValoresCategorias(text: 'Poodle'),
    ValoresCategorias(text: 'Fila')
  ]),
  ValoresCategorias(text: 'Gato', list: [
    ValoresCategorias(text: 'Persa'),
    ValoresCategorias(text: 'Chaninha'),
  ]),
  ValoresCategorias(text: 'Coelho'),
];

class CadastrarReprodutoresScreen extends StatefulWidget {
  @override
  _CadastrarReprodutoresScreenState createState() =>
      _CadastrarReprodutoresScreenState();
}

class _CadastrarReprodutoresScreenState
    extends State<CadastrarReprodutoresScreen> {
  final controller = PetRegistrationController();

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  final _bloc = ReprodutoresBloc();

  String title = 'Selecione a categoria';

  final _tNome = TextEditingController(text: 'Reprodutor');
  String _tCategoria = '';
  String _tEspecie = 'Selecione a categoria';

  _onSavePressed() async {
    String nome = _tNome.text;
    bool isMacho = true;
    EspecificacoesAnimalModel categoria =
        EspecificacoesAnimalModel(categoria: _tCategoria, especie: _tEspecie);

    var response = await _bloc.register(nome, categoria, isMacho);

    if (response)
      popUntil(context, Routes.Reprodutores);
    else
      alert(context, 'Error na criação de reprodutor!');
  }

  _setCategory(String categoria, String especie) {
    setState(() {
      _tCategoria = categoria;
      _tEspecie = especie;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = ScaffoldCommonComponents.customAppBar(
      'Registrar',
      () => Navigator.pop(context),
    );
    var body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        children: [
          ImagePickerTileWidget(
            title: 'Foto',
            // fileSetter: fileSetter,
          ),
          TextFormField(
            onChanged: (val) {
              controller.nome = val;
            },
            controller: _tNome,
            decoration: InputDecoration(
              hintText: 'Nome',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),
          ListTile(
            //TODO: Tentar colocar em forma de widget reutilizavel
            title: Text(_tEspecie),
            subtitle: Text('*Selecione a categoria'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              push(
                context,
                CategoryScreen(
                  title: 'Categorias',
                  settaValores: _setCategory,
                  valores: listaDeValores,
                ),
              );
            },
          ),
          controller.isRequired != null
              ? Text(
                  controller.isRequired!,
                  style: kErrorTextStyle,
                )
              : Container(),
          ListTile(
            title: Text(controller.isMacho ? 'Macho' : 'Fêmea'),
            subtitle: Text('*Selecione o gênero'),
            trailing: Switch(
              value: !controller.isMacho,
              onChanged: (val) {
                setState(() {
                  controller.isMacho = !val;
                });
              },
              activeColor: Colors.red,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.blue,
              inactiveThumbColor: Colors.blue,
            ),
            onTap: () {
              setState(() {
                controller.isMacho = !controller.isMacho;
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

    var bottomNavBar = StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return CustomButtonWidget(
          'Register',
          onPressed: _onSavePressed,
          showProgress: snapshot.data ?? false,
        );
      },
    );

    return Scaffold(
      body: body,
      appBar: appBar,
      bottomNavigationBar: bottomNavBar,
    );
  }
}
