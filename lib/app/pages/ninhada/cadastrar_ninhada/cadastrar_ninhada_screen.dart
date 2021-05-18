import 'package:flutter/material.dart';

import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/expanded_dropdown_widget.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/ninhada/cadastrar_filhote/cadastrar_filhote_screen.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/constants.dart';

enum PetCategory {
  Cat,
  Dog,
  Hamster,
  Rabbit,
}

class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _bottomAppBar(size, context),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cadastrar ninhada',
          style: kTitleTextStyle,
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            ),
            onPressed: () => back(context),
          );
        }),
      ),
      //TODO: Estudar como botar o singleChildScrollView
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              ImagePickerTileWidget(
                title: 'Foto',
                // fileSetter: fileSetter,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Titulo da ninhada',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Data de nascimento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),

              ExpandedDropDownWidget(
                lista: ['Cachorro', 'Gato', 'Coelho'], //TODO: Nome muito grande faz a formatacao do titulo ficar tortar
                texto: 'Selecione a Categoria',
              ),
              ExpandedDropDownWidget(
                lista: ['Persa', 'Miau', 'Aulaula'],
                texto: 'Selecione a Especie',
              ),
              ExpandedDropDownWidget(
                lista: ['Persa', 'Miau', 'Aulaula'],
                texto: 'Selecione a Mãe',
              ),
              ExpandedDropDownWidget(
                lista: ['Persa', 'Miau', 'Aulaula'], //TODO: Passar os dog macho da mesma especie
                texto: 'Selecione o Pai',
              ),

              JaNasceuCheckBoxWidget(),
              //TODO: Se tiver marcado, vai pra prox pagina(para cadastrar os filhotes), se nao, envia o formulario
              //TODO: Posso perguntar as cores dos filhotes pra ja facilitar o preenchimento depois(Todos nasceram da mesma cor? Qual cor dos filhotes)
            ],
          ),
        ),
      ),
    );
  }

  BottomAppBar _bottomAppBar(Size size, BuildContext context) {
    return BottomAppBar(
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
          title: 'Avançar',
          onPressed: () => push(
            context,
            CadastrarFilhoteScreen(),
          ),
        ),
      ),
    );
  }
}

class JaNasceuCheckBoxWidget extends StatefulWidget {
  @override
  _JaNasceuCheckBoxWidgetState createState() => _JaNasceuCheckBoxWidgetState();
}

class _JaNasceuCheckBoxWidgetState extends State<JaNasceuCheckBoxWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _value,
      onChanged: (val) {
        if (val != null)
          setState(() {
            _value = val;
          });
      },
      title: Text('Nasceram'),
      subtitle: Text('Marque caso os filhotes ja tenham nascido'),
    );
  }
}

class FieldWidget extends StatelessWidget {
  final Widget child;
  const FieldWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
