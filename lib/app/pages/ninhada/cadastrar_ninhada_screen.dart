import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_bloc.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

import 'drop_down_button_widget.dart';

class PaiMaeItem extends DropDownItem {
  String nome;
  EspecificacoesAnimalModel? specs;
  String referenceId;
  PaiMaeItem({
    required this.nome,
    this.specs,
    required this.referenceId,
  });

  @override
  String text() {
    return nome;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaiMaeItem &&
        other.nome == nome &&
        other.referenceId == referenceId;
  }

  @override
  int get hashCode => nome.hashCode ^ referenceId.hashCode;
}


class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  final _bloc = NinhadaBloc();

  final _tTitulo = TextEditingController(text: 'Ninhada');
  PaiMaeItem? _tMae;
  PaiMaeItem? _tPai;
  EspecificacoesAnimalModel? specs;

  _onCreatePressed() async {
    await _bloc.create(
      'titulo',
      'fotoUrl',
      'dataNascimento',
      EspecificacoesAnimalModel(categoria: 'categoria', especie: 'especie'),
      p1, //TODO: Enviar referencia
      m1, //TODO: Enviar referencia
    );
    pop(context);
  }

  @override
  void initState() {
    super.initState();
    _bloc.fetchPai(
      // 'specs',
      true,
    );
  }

  _onMaeChanged(v) {
    print(v.runtimeType);
    if (v.runtimeType == PaiMaeItem) {
      print(v.nome);
      print(v.referenceId);
      setState(() {
        _tMae = v;
      });
    }
  }

  _onPaiChanged(v) {
    print(v.runtimeType);
    if (v.runtimeType == PaiMaeItem) {
      print(v.nome);
      print(v.referenceId);
      setState(() {
        _tPai = v;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBar = ScaffoldCommonComponents.customBottomAppBar(
      'Cadastrar',
      _onCreatePressed,
      context,
    );
    var appBar = ScaffoldCommonComponents.customAppBar(
      'Cadastrar ninhada',
      () => pop(context),
    );
    var body = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _tTitulo,
              decoration: InputDecoration(
                hintText: 'Titulo da ninhada',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropDownButtonWidget<PaiMaeItem>(
                value: _tMae,
                hint: 'Selecione a mae',
                items: [],
                onChanged: _onMaeChanged,
                // hint: 'Teste',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: StreamBuilder<List<PaiMaeItem>>(
                  stream: _bloc.paiList.stream,
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      var list = snapshot.data;
                      if (list != null)
                        return DropDownButtonWidget<PaiMaeItem>(
                          value: _tPai,
                          hint: 'Selecione o pai',
                          items: list,
                          onChanged: _onPaiChanged,
                          // hint: 'Teste',
                        );
                    }
                    return Text('Carregando');
                  }),
            ),

//TODO: Exibir error

//TODO: Implementar dropdown do pai

            //TODO: Exibir error

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
    );

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      body: body,
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
