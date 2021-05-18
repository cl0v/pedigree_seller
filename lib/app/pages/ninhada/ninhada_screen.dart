import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/models/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/cadastrar_ninhada/cadastrar_ninhada_screen.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

import '../../../constants.dart';

class NinhadasScreen extends StatefulWidget {
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen> {
  List<NinhadaModel> ninhadaList = ninhadaListMock;
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
          'Ninhada',
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
        child: ListView.builder(
          itemCount: ninhadaList.length,
          itemBuilder: (context, index) {
            var ninhada = ninhadaList[index];
            //TODO: OnTap para editar
            //TODO: Botao de criar para criar;
            return ListTile(
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      //TODO: Mostrar na tela de pet(o de vendar), como ta ficando
                    },
                  ), // icon-1
                  IconButton(
                    icon: Icon(Icons.adaptive.more),
                    onPressed: () {
                      //Mostrar um popupmenubutton com as opçoes de editar, deletar, (Add arquivar), etc;
                    },
                  ), // icon-1
                  // Icon(Icons.adaptive.more), // icon-2
                ],
              ),
              title: Text(
                ninhada.titulo,
              ),
            );
          },
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
          title: 'Cadastrar ninhada',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastrarNinhadaScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
