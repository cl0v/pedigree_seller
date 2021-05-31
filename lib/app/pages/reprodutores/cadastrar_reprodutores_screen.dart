//TODO: Minha tarefa de hoje é enviar a foto do bixo e do certificado para o servidor
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/components/form_error_text.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_bloc.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/alert.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class CadastrarReprodutoresScreen extends StatefulWidget {
  @override
  _CadastrarReprodutoresScreenState createState() =>
      _CadastrarReprodutoresScreenState();
}

class _CadastrarReprodutoresScreenState
    extends State<CadastrarReprodutoresScreen> {
  late final _bloc;

  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    CanilModel.get().then((c) {
      if (c != null) _bloc = ReprodutoresBloc(c);
      setState(() {
        _dataLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.registerBtnBloc.dispose();
  }

  bool _showError = false;

  bool _isMacho = true;

  final _tNome = TextEditingController();

  String? _validateNome() {
    var text = _tNome.text;
    if (text.isEmpty) {
      return "Digite um nome";
    }
    return null;
  }

  String _tCategoria = '';
  String _tEspecie = 'Selecione a categoria';

  String? _validateCategory() {
    //TODO: Corrigir o possivel bug da categoria, quando a especie nao existir(Ex: Outros)
    var c = _tCategoria;
    var e = _tEspecie;
    if (c.isEmpty || e == 'Selecione a categoria' || e.isEmpty) {
      return "Especifique uma categoria";
    }
    return null;
  }

  String? _validadePedigree() {
    // if(pedigreeFile == null) return 'Selecione uma foto';
    return null;
  }

  String? _validateFoto() {
    // if(foto == null) return 'Selecione uma foto';
    return null;
  }

  _onSave() async {
    if (!(_validateNome() == null &&
        _validateCategory() == null &&
        _validadePedigree() == null &&
        _validateFoto() == null)) {
      setState(() {
        _showError = true;
      });
      return;
    }

    String nome = _tNome.text;
    bool isMacho = _isMacho;
    CategoriaAnimal categoria = CategoriaAnimal(
      categoria: _tCategoria,
      especie: _tEspecie,
    );

    Reprodutor reprodutorModel = Reprodutor(
      nome: nome,
      categoria: categoria,
      isMacho: isMacho,
    );

    var response = await _bloc.register(foto!, reprodutorModel, pedigreeFile!);

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

  late Foto? pedigreeFile;
  late Foto? foto;
//TODO: Validar pedigree

  _onPedigreeChanged(Foto foto) {
    //TODO: Fazer a verificação
    pedigreeFile = foto;
  }

  _onFotoChanged(Foto foto) {
    this.foto = foto;
  }

  @override
  Widget build(BuildContext context) {
    var appBar = ScaffoldCommonComponents.customAppBar(
      'Registrar',
      () => pop(context),
    );

    var bottomNavBar = _dataLoaded
        ? StreamBuilder(
            stream: _bloc.registerBtnBloc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return ScaffoldCommonComponents.customBottomAppBar(
                'Register',
                _onSave,
                context,
                snapshot.data ?? false,
              );
            },
          )
        : Container();

    var body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        children: [
          ImagePickerTileWidget(
            title: 'Foto',
            onChanged: _onFotoChanged,
          ),
          _validateFoto() != null && _showError
              ? FormErrorText(_validateFoto()!)
              : Container(),
          TextFormField(
            controller: _tNome,
            decoration: InputDecoration(
              labelText: 'Nome',
              hintText: 'Ex: Rex',
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
          ListTile(
            title: Text(_tEspecie),
            subtitle: Text('*Selecione a categoria'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              push(
                context,
                CategorySelectorScreen(
                  title: 'Categorias',
                  onValuesChanged: _setCategory,
                  valores: listaDeValores,
                  route: Routes.CadastrarReprodutor,
                ),
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
          ),
          _validadePedigree() != null && _showError
              ? FormErrorText(_validadePedigree()!)
              : Container(),
        ],
      ),
    );

    return Scaffold(
        body: body, appBar: appBar, bottomNavigationBar: bottomNavBar);
  }
}
