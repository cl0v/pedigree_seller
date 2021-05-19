import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/models/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/cadastrar_ninhada/cadastrar_ninhada_screen.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

//TODO: Colocar indicador avisando o status do anuncio
//Aprovado, Negado, Aguardando

class NinhadaController {
  List<NovaNinhadaModel> ninhadaList = [];

  Future<List<NovaNinhadaModel>> fetchNinhadas() async {
    return ninhadaList;
  }
}

class NinhadasScreen extends StatefulWidget {
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen> {
  final controller = NinhadaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScaffoldCommonComponents.customBottomAppBar(
        'Cadastrar ninhada',
        () async {
          NovaNinhadaModel? ninhada = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastrarNinhadaScreen(),
            ),
          );
          if (ninhada != null)
            setState(
              () {
                controller.ninhadaList.add(ninhada);
              },
            );
        },
        context,
      ),
      appBar: ScaffoldCommonComponents.customAppBar(
        'Ninhada',
        () => back(
          context,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<NovaNinhadaModel>>(
          future: controller.fetchNinhadas(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                var ninhadas = snapshot.data!;
                if (ninhadas.isEmpty)
                  return Center(
                    child: Text('Nenhuma ninhada cadastrada'),
                  );
                return ListView.builder(
                  itemCount: ninhadas.length,
                  itemBuilder: (context, index) {
                    var ninhada = ninhadas[index];
                    //TODO: OnTap para editar
                    //TODO: Botao de criar para criar;
                    return ListTile(
                      leading: Text('Aguardando'), //TODO: Adicionar status
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
                );

              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              default:
                return Center(
                  child: Text('Ocorreu um erro, por favor tente mais tarte'),
                );
            }
          },
        ),
      ),
    );
  }
}
