//TODO: Recriar a pagina para deixar bem claro como vai ficar na hora de adicionar(Quadrado grandao pra enviar foto, setinha pra botar nome, etc)
//TODO: Permitir que a página que cria é a mesma que edita

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/components/form_error_text.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_bloc.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/alert.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

///Página de triagem, para facilitar o preenchimento dos dados mais comuns(Especie, titulo e categoria, macho femea etc))
///Cadastrar os animais reprodutores (Pai e Mae)
///Para agilizar o cadastro da ninhada
///

class CadastrarReprodutoresScreen extends StatefulWidget {
  @override
  _CadastrarReprodutoresScreenState createState() =>
      _CadastrarReprodutoresScreenState();
}

class _CadastrarReprodutoresScreenState
    extends State<CadastrarReprodutoresScreen> {
  @override
  void dispose() {
    super.dispose();
    _bloc.registerBtn.dispose();
  }

  final _bloc = ReprodutoresBloc();

  bool _showError = false;

  bool _isMacho = true;

  final _tNome = TextEditingController(text: 'Reprodutor');
  String? _validateNome() {
    //TODO: Implement
    var text = _tNome.text;
    if (text.isEmpty) {
      return "Digite um nome";
    }
    return null;
  }

  String _tCategoria = '';
  String _tEspecie = 'Selecione a categoria';

  String? _validateCategory() {
    var c = _tCategoria;
    var e = _tEspecie;
    if (c.isEmpty || e == 'Selecione a categoria' || e.isEmpty) {
      return "Especifique uma categoria";
    }
    return null;
  }

  _onSavePressed() async {
    if (!(_validateNome() == null && _validateCategory() == null)) {
      setState(() {
        _showError = true;
      });
      return;
    }

    String nome = _tNome.text;
    bool isMacho = _isMacho;
    EspecificacoesAnimalModel categoria = EspecificacoesAnimalModel(
      categoria: _tCategoria,
      especie: _tEspecie,
    );

    var response = await _bloc.register(nome, categoria, isMacho, pedigreeFile!);

    if (response)
      pop(context);
    else
      alert(context, 'Error na criação de reprodutor!');
  }

  _setCategory(String categoria, String especie) {
    setState(() {
      _tCategoria = categoria;
      _tEspecie = especie;
    });
  }

  File? pedigreeFile;

  _onPedigreeChanged(File? file) {
    pedigreeFile = file;
    print('tudo bugado');
    // print(file?.isAbsolute);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = ScaffoldCommonComponents.customAppBar(
      'Registrar',
      () => pop(context),
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
          _validateNome() != null && _showError
              ? FormErrorText(_validateNome()!)
              : Container(),
          //TODO: Tentar colocar em forma de widget reutilizavel
          ListTile(
            title: Text(_tEspecie),
            subtitle: Text('*Selecione a categoria'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              push(
                context,
                CategorySelectorScreen(
                    title: 'Categorias',
                    settaValores: _setCategory,
                    valores: listaDeValores,
                    route: Routes.CadastrarReprodutor),
              );
            },
          ),
          _validateCategory() != null && _showError
              ? FormErrorText(_validateCategory()!)
              : Container(),
          ListTile(
            title: Text(_isMacho ? 'Macho' : 'Fêmea'),
            subtitle: Text('*Selecione o gênero'),
            trailing: Switch(
              value: !_isMacho,
              onChanged: (val) {
                setState(() {
                  _isMacho = !val;
                });
              },
              activeColor: Colors.red,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.blue,
              inactiveThumbColor: Colors.blue,
            ),
            onTap: () {
              setState(() {
                _isMacho = !_isMacho;
              });
            },
          ),
          ImagePickerTileWidget(
            title: 'Certificado de Pedigree',
            onChanged: _onPedigreeChanged,
          )
        ],
      ),
    );

    var bottomNavBar = StreamBuilder(
      stream: _bloc.registerBtn.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ScaffoldCommonComponents.customBottomAppBar(
          'Register',
          _onSavePressed,
          context,
          snapshot.data ?? false,
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
