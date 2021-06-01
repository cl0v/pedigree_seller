import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/components/drop_down_button_widget.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_bloc.dart';

import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/alert.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  late final NinhadaBloc _bloc;

  bool _loadedData = false;

  @override
  void initState() {
    super.initState();
    CanilModel.get().then((c) {
      if (c != null) _bloc = NinhadaBloc(c);
      setState(() {
        _loadedData = true;
      });
    });

    // _bloc.fetchPai(
    //   null,
    // );
  }

  final _tTitulo = TextEditingController();

  CategoriaAnimal? _categoria;

  Reprodutor? _tPai;
  Reprodutor? _tMae;

  bool _showDropDown = false;

  @override
  dispose() {
    super.dispose();
    _bloc.createBtnBloc.dispose();
    _bloc.maesBloc.dispose();
    _bloc.paisBloc.dispose();
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

  //TODO: Fazer as validações
  _onCreatePressed() async {
    //TODO: Se eu tentar cadastrar sem a foto, pode dar biziu
    if (_tTitulo.text == '' || _categoria == null)
      return alert(context, 'Por favor preencha todos os campos');
    if (foto != null) {
      await _bloc.create(
        _tTitulo.text,
        foto!,
        _categoria,
        _tPai!.nome,
        _tMae!.nome,
      );
      pop(context);
    } else
      alert(context, 'Não foi possivel cadastrar, pois voce nao enviou imagem');
  }

  _onMaeChanged(v) {
    if (v.runtimeType == Reprodutor) {
      v = v as Reprodutor;
      setState(() {
        _tMae = v;
      });
    }
  }

  _onPaiChanged(v) {
    if (v.runtimeType == Reprodutor) {
      v = v as Reprodutor;
      setState(() {
        _tPai = v;
      });
    }
  }

  Foto? foto;
  _onFotoChanged(Foto foto) {
    //TODO: Implement enviar foto
    this.foto = foto;
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavBar = _loadedData
        ? StreamBuilder(
            stream: _bloc.createBtnBloc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return ScaffoldCommonComponents.customBottomAppBar(
                'Continuar',
                _continue ? _onCreatePressed : null,
                context,
                snapshot.data ?? false,
              );
            },
          )
        : Container();
    var appBar = ScaffoldCommonComponents.customAppBar(
      'Cadastrar ninhada',
      () => pop(context),
    );
    var body = _loadedData
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  ImagePickerTileWidget(
                    title: 'Foto',
                    onChanged: _onFotoChanged,
                  ),
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
                            StreamBuilder<List<Reprodutor>>(
                                stream: _bloc.maesBloc.stream,
                                builder: (context, snapshot) {
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
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                          onTap: () => pushNamed(context,
                                              Routes.CadastrarReprodutor),
                                        );
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: DropDownButtonWidget<Reprodutor>(
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
                            StreamBuilder<List<Reprodutor>>(
                                stream: _bloc.paisBloc.stream,
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
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                          onTap: () => pushNamed(
                                            context,
                                            Routes.CadastrarReprodutor,
                                          ),
                                        );
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropDownButtonWidget<Reprodutor>(
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
          )
        : Center(
            child: CircularProgressIndicator(),
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
