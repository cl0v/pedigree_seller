import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import '../../../../constants.dart';

//TODO: Melhorar a forma de adicionar novos filhotes

class CadastrarFilhoteScreen extends StatefulWidget {
  @override
  _CadastrarFilhoteScreenState createState() => _CadastrarFilhoteScreenState();
}

class _CadastrarFilhoteScreenState extends State<CadastrarFilhoteScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _bottomAppBar(size, context),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cadastrar filhotes',
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
      body: CadastrarFilhotesWidget(),
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
          title: 'Concluir',
          onPressed: () => backToHome(context),
          //TODO: Corrigir esse back to Home
        ),
      ),
    );
  }
}

class CadastrarFilhotesWidget extends StatefulWidget {
  @override
  _CadastrarFilhotesWidgetState createState() =>
      _CadastrarFilhotesWidgetState();
}

class _CadastrarFilhotesWidgetState extends State<CadastrarFilhotesWidget> {
  List<String> filhotesTitulos = [];
  List<bool> sexoList = [];

  List<String> listaDeCoresDisponiveis = [
    'Vermelho',
    'Verde',
    'Azul',
    'Laranja'
  ];

  int filhotesAmount = 0;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Adicionar filhotes'),
      children: [
        ...List.generate(filhotesAmount, (index) {
          // var titulo = filhotesTitulos[index];
          var sexo = sexoList[index];
          return FilhoteTileWidget(
            listaCores: listaDeCoresDisponiveis,
            sexo: sexo,
            titulo: 'Filhote ${index + 1}',
          );
        }),
        ListTile(
          title: Text('Adicionar filhote'),
          leading: Icon(Icons.add),
          onTap: () {
            filhotesTitulos.add('Jorge');
            sexoList.add(false);
            setState(() {
              filhotesAmount++;
            });
          },
        ),
      ],
    );
  }
}

class FilhoteTileWidget extends StatefulWidget {
  final List<String> listaCores;
  final String titulo;
  final bool sexo;

  const FilhoteTileWidget({
    Key? key,
    required this.titulo,
    required this.listaCores,
    required this.sexo,
  }) : super(key: key);

  @override
  _FilhoteTileWidgetState createState() => _FilhoteTileWidgetState();
}

class _FilhoteTileWidgetState extends State<FilhoteTileWidget> {
  late String _selectedColor;

//Dar um jeito de excluir os filhotes

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.listaCores.first;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: //Sexo
          Checkbox(
        value: false,
        onChanged: (va) {},
      ),
      leading: Text(widget.titulo),
      title: PopupMenuButton<String>(
        child: Text('Cor: $_selectedColor'),
        onSelected: (val) {
          setState(() {
            _selectedColor = val;
          });
        },
        itemBuilder: (context) {
          return widget.listaCores
              .map(
                (e) => PopupMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList();
          // return [
          //   PopupMenuItem(child: Text(widget.listaCores[0])),
          //   PopupMenuItem(child: Text(widget.listaCores[1])),
          // ];
        },
      ),
    );
  }
}
