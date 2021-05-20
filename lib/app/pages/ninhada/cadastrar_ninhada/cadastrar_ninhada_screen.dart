import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/expanded_dropdown_widget.dart';
import 'package:pedigree_seller/app/models/ninhada_model.dart';
import 'package:pedigree_seller/app/models/reprodutores_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';

//TODO: Tentar replicar o InputDecoration.errorText;

class CadastrarNinhadaController {
  //ScreenController
  String titulo = 'Nova ninhada';
  ReprodutorModel? _mae;
  ReprodutorModel? _pai;
  bool nascidos = false;

  bool isMaeSelected = false;
  bool isPaiSelected = false;

  bool confirmed = false;

  //TODO: Opção de não informar quantidade(Para o anuncio ficar sempre ativo)

  onConfirmPressed(context) async {
    if (isMaeSelected && isPaiSelected) {
      NovaNinhadaModel ninhada = NovaNinhadaModel(
        titulo: titulo,
        mae: _mae!,
        categoria: _mae!.categoria.category,
        especie: _mae!.categoria.especie,
        pai: _pai!,
        nascidos: nascidos,
      );
      await saveNinhada(ninhada);
      back(context, ninhada);
    } else {
      confirmed = true;
    }
  }

  Future saveNinhada(NovaNinhadaModel ninhada) async {
    //TODO: Implement Salvar no banco
    print(ninhada);
  }

  Future<List<String>> fetchMaes() async {
    //TODO: Implement Receber do banco
    return [p1, p2, m1, m2]
        .where((p) => p.isMacho == false)
        .map((r) => r.nome)
        .toList();
  }

  // Future<List<String>> fetchPais([ReprodutorOptions options]) async {
  Future<List<String>> fetchPais() async {
    //TODO: Implement Receber do banco
    return [p1, p2, m1, m2]
        .where((p) => p.isMacho == true)
        .map((r) => r.nome)
        .toList();
  }

  setSelectedAnimal(String title) {
    //TODO: Melhorar isso
    var dog = [p1, p2, m1, m2].firstWhere((p) => p.nome == title);
    if (dog.isMacho) {
      _pai = dog;
      isPaiSelected = true;
    } else {
      _mae = dog;
      isMaeSelected = true;
    }
  }

  //Providers connection

  // O primeiro a ser escolhido vai definir o segundo,
  // ja que deve ter as mesmas caracteristicas
  // where(p1.config == bixo.config).toList

}

class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  final controller = CadastrarNinhadaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScaffoldCommonComponents.customBottomAppBar(
        'Avançar',
        () => setState(
          () {
            controller.onConfirmPressed(context);
          },
        ),
        context,
      ),
      appBar: ScaffoldCommonComponents.customAppBar(
        'Cadastrar ninhada',
        () => back(context),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              TextFormField(
                onChanged: (val) {
                  controller.titulo = val;
                },
                decoration: InputDecoration(
                  hintText: 'Titulo da ninhada',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),

              FutureBuilder<List<String>>(
                future: controller.fetchMaes(),
                builder: (context, snapshot) {
                  List<String> l = [];
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      l = snapshot.data!;
                      break;
                    default:
                      l = [];
                  }
                  return ExpandedDropDownWidget(
                    lista: l,
                    controller: controller,
                    texto: 'Selecione a Mãe',
                  );
                },
              ),

              !controller.isMaeSelected && controller.confirmed
                  ? Text(
                      'Campo necessário',
                      style: kErrorTextStyle,
                    )
                  : Container(),
              FutureBuilder<List<String>>(
                future: controller.fetchPais(),
                builder: (context, snapshot) {
                  List<String> l = [];
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      l = snapshot.data!;
                      break;
                    default:
                      l = [];
                  }
                  return ExpandedDropDownWidget(
                    lista: l,
                    controller: controller,
                    texto: 'Selecione o Pai',
                  );
                },
              ),

              !controller.isPaiSelected && controller.confirmed
                  ? Text(
                      'Campo necessário',
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
