import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/components/drop_down_button_widget.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_bloc.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  final _bloc = NinhadaBloc();

  final _tTitulo = TextEditingController();

  CategoriaAnimal? _categoria;

  PaiMaeItem? _tPai;
  PaiMaeItem? _tMae;

  bool _showDropDown = false;

  @override
  dispose() {
    super.dispose();
    _bloc.createBtn.dispose();
    _bloc.maeList.dispose();
    _bloc.paiList.dispose();
  }

  _setCategory(String categoria, String especie) {
    setState(() {
      _categoria = CategoriaAnimal(
        categoria: categoria,
        especie: especie,
      );
      _showDropDown = true;
      if (_categoria != null) _bloc.fetchReprodutores(_categoria!);
      //TODO: Quando troca a categoria pela segunda vez, nao atualiza as opções
    });
  }

  bool _continue = true;

  _onCreatePressed() async {
    //TODO: Fazer as validações
    await _bloc.create(
      _tTitulo.text,
      'Foto',
      _categoria,
      _tPai!.referenceId!,
      _tMae!.referenceId!,
    );
    pop(context);
  }

  @override
  void initState() {
    super.initState();
    // _bloc.fetchPai(
    //   null,
    // );
  }

  _onMaeChanged(v) {
    if (v.runtimeType == PaiMaeItem) {
      print(v.nome);
      print(v.referenceId);
      setState(() {
        _tMae = v;
      });
    }
  }

  _onPaiChanged(v) {
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
    var bottomNavBar = StreamBuilder(
      stream: _bloc.createBtn.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ScaffoldCommonComponents.customBottomAppBar(
          'Continuar',
          _continue ? _onCreatePressed : null,
          context,
          snapshot.data ?? false,
        );
      },
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
                labelText: 'Titulo',
                hintText: 'Ex: Wooly Red',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            ListTile(
              title: Text(_categoria?.especie ?? 'Selecione a categoria'),
              subtitle: Text('*Selecione a categoria'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                push(
                  context,
                  CategorySelectorScreen(
                    title: 'Categorias',
                    onValuesChanged: _setCategory,
                    valores: listaDeValores,
                    route: Routes.CadastrarNinhada,
                  ),
                );
              },
            ),
            _showDropDown
                ? Column(
                    children: [
                      StreamBuilder<List<PaiMaeItem>>(
                          stream: _bloc.maeList.stream,
                          builder: (context, snapshot) {
                            print(snapshot);
                            if (snapshot.hasData) {
                              var list = snapshot.data;
                              if (list != null) {
                                if (list.isEmpty)
                                  return ListTile(
                                    title: Text(
                                      'Você não tem nenhuma fêmea dessa espécie cadastrada',
                                    ),
                                    subtitle: Text(
                                      'Toque para cadastrar um reprodutor',
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: () => pushNamed(
                                        context, Routes.CadastrarReprodutor),
                                  );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: DropDownButtonWidget<PaiMaeItem>(
                                    value: _tMae,
                                    hint: 'Selecione a mae',
                                    items: list,
                                    onChanged: _onMaeChanged,
                                    // hint: 'Teste',
                                  ),
                                );
                              }
                            }
                            return LinearProgressIndicator();
                          }),
                      StreamBuilder<List<PaiMaeItem>>(
                          stream: _bloc.paiList.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var list = snapshot.data;
                              if (list != null) {
                                if (list.isEmpty)
                                  return ListTile(
                                    title: Text(
                                      'Você não tem nenhum macho dessa espécie cadastrado',
                                    ),
                                    subtitle: Text(
                                      'Toque para cadastrar um reprodutor',
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: () => pushNamed(
                                      context,
                                      Routes.CadastrarReprodutor,
                                    ),
                                  );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropDownButtonWidget<PaiMaeItem>(
                                    value: _tPai,
                                    hint: 'Selecione o pai',
                                    items: list,
                                    onChanged: _onPaiChanged,
                                    // hint: 'Teste',
                                  ),
                                );
                              }
                            }
                            return LinearProgressIndicator();
                          }),
                    ],
                  )
                : Container()

            //TODO: Nao permitir avançar enquanto nao preencher as infos corretas caso esteja true

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
      bottomNavigationBar: bottomNavBar,
      appBar: appBar,
      body: body,
    );
  }
}

class Avancados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
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
