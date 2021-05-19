import 'package:flutter/material.dart';

import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/expanded_dropdown_widget.dart';
import 'package:pedigree_seller/app/models/ninhada_model.dart';
import 'package:pedigree_seller/app/models/reprodutores_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/constants.dart';

class CadastrarNinhadaController {
  String _titulo = 'Nova ninhada';
  set tituloSetter(String s) => _titulo = s;
  get tituloGetter => _titulo;
  ReprodutorModel? _mae;
  set maeSetter(ReprodutorModel m) => _mae = m;
  ReprodutorModel? _pai;
  set paiSetter(ReprodutorModel p) => _pai = p;
  bool nascidos = false;

  String? isRequired;

  onConfirmPressed(context) {
    print((_mae != null && _pai != null));
    if (_mae != null && _pai != null) {
      NovaNinhadaModel ninhada = NovaNinhadaModel(
        titulo: _titulo,
        mae: _mae!,
        pai: _pai!,
        nascidos: nascidos,
      );
      back(context, ninhada);
    } else {
      isRequired = 'Campo necessário';
    }
  }

  List<String> fetchListaMaes() {
    return [m1.nome, m2.nome];
  }

  //O primeiro a ser escolhido vai definir o segundo,
  // ja que deve ter as mesmas caracteristicas
  //where(p1.config == bixo.config).toList
  List<String> fetchListaPaes() {
    return [p2.nome, p1.nome];
  }

  setPaiTitulo(String title) {
    var dog = [p1, p2, m1, m2].firstWhere((p) => p.nome == title);
    if (dog.isMacho) {
      paiSetter = dog;
    } else
      maeSetter = dog;
  }
}

class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  final controller = CadastrarNinhadaController();


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
              TextFormField(
                onChanged: (val) {
                  controller.tituloSetter = val;
                  controller.isRequired = null;
                },
                decoration: InputDecoration(
                  hintText: 'Titulo da ninhada',
                  // errorText: controller.isRequired,
                  //TODO: Descobrir como é feito esse texto
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),

              ExpandedDropDownWidget(
                lista: controller.fetchListaMaes(),
                controller: controller,
                texto: 'Selecione a Mãe',
              ),
              controller.isRequired != null
                  ? Text(
                      controller.isRequired!,
                      style: kErrorTextStyle,
                    )
                  : Container(),
              ExpandedDropDownWidget(
                lista: controller
                    .fetchListaPaes(), //TODO: Passar os dog macho da mesma especie
                controller: controller,
                texto: 'Selecione o Pai',
              ),
              controller.isRequired != null
                  ? Text(
                      controller.isRequired!,
                      style: kErrorTextStyle,
                    )
                  : Container(),
              //TODO: Ja começar com valor true ou substituir para não nasceram ainda
              // JaNasceuCheckBoxWidget(
              //   controller: controller,
              //   onChanged: () {
              //     setState(() {});
              //   },
              // ),
              Divider(),
              //TODO: Nao permitir avançar enquanto nao preencher as infos corretas caso esteja true
              //TODO: Posso desativar os botoes tambem (tem parametros deactivated/disabled)
              //TODO: Mostrar apenas se marcar daqui pra baixo

              // ImagePickerTileWidget(
              //   title: 'Foto',
              // ),
              // CustomDatePicker(
              //   enabled: controller.nascidos,
              // ),
              // TextFormField(
              //   onChanged: controller.onQuantidadeChanged,
              //   // controller: quantidadeFilhotesController,
              //   decoration: InputDecoration(
              //     // enabled: controller.nascidos,
              //     hintText: 'Quantidade de filhotes',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(
              //         12,
              //       ),
              //     ),
              //   ),
              // ),

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
          onPressed: () => setState(() {
            controller.onConfirmPressed(context);
          }),
        ),
      ),
    );
  }
}

class JaNasceuCheckBoxWidget extends StatefulWidget {
  final controller;
  final onChanged;

  const JaNasceuCheckBoxWidget(
      {Key? key, required this.controller, required this.onChanged})
      : super(key: key);
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
            widget.controller.nascidos = val;
            _value = val;
            widget.onChanged();
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
