import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/models/raca_model.dart';
import 'package:pedigree_seller/app/models/reprodutores_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';

//TODO: Recriar a pagina para deixar bem claro como vai ficar na hora de adicionar(Quadrado grandao pra enviar foto, setinha pra botar nome, etc)
//TODO: Permitir que a página que cria é a mesma que edita

///Página de triagem, para facilitar o preenchimento dos dados mais comuns(Especie, titulo e categoria, macho femea etc))
///Cadastrar os animais reprodutores (Pai e Mae)
///Para agilizar o cadastro da ninhada

enum CategorySteps {
  Categoria,
  Especie,
}

class PetRegistrationController {
  bool isMacho = true;
  String nome = 'Reprodutor';
  String? isRequired;

  CategorySteps steps = CategorySteps.Categoria;
  String categoria = '';
  String especie = '';

  List<String> fetchCategoryStringList(int val) {
    switch (val) {
      case 0:
        return fetchCategorias();
      case 1:
        return fetchEspecies(categoria);
    }
    return fetchCategorias();
  }

  List<String> fetchCategorias() {
    return racas.keys.toList();
  }

  List<String> fetchEspecies(String categoria) {
    return racas[categoria]!;
  }

  Future onRegisterPressed(context) async {
    if (categoria != '' && especie != '') {
      ReprodutorModel reprodutor = ReprodutorModel(
        nome: nome,
        categoria: Raca(category: categoria, especie: especie),
        isMacho: isMacho,
      );
      await saveReprodutor(reprodutor);
      back(context, reprodutor);
    } else {
      isRequired = 'Campo necessário';
    }
  }

  Future saveReprodutor(ReprodutorModel reprodutor) async {
    //TODO: implement saveReprodutor
  }
}

class CadastrarReprodutoresScreen extends StatefulWidget {
  @override
  _CadastrarReprodutoresScreenState createState() =>
      _CadastrarReprodutoresScreenState();
}

class _CadastrarReprodutoresScreenState
    extends State<CadastrarReprodutoresScreen> {
  final controller = PetRegistrationController();

  String title = 'Selecione a categoria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: ScaffoldCommonComponents.customAppBar(
        'Registrar',
        () => Navigator.pop(context),
      ),
      bottomNavigationBar: ScaffoldCommonComponents.customBottomAppBar(
        'Cadastrar',
        () async {
          setState(() {
            controller.onRegisterPressed(context);
          });
        },
        context,
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
              controller.nome = val;
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
              push(
                context,
                CategoryScreen(
                  controller: controller,
                  onUpdate: () {
                    setState(() {
                      title = controller.especie;
                    });
                  },
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
  }
}
