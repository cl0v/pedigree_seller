import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_bloc.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

//TODO: Quando for cadastrar ninhada, usar o dropdown das ultimas aulas do curso
//aula 225

//TODO: Colocar indicador avisando o status do anuncio
//Aprovado, Negado, Aguardando


class NinhadasScreen extends StatefulWidget {
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen> {
  final _bloc = NinhadaBloc();


  @override
  Widget build(BuildContext context) {
    var bottomNavigationBar = ScaffoldCommonComponents.customBottomAppBar(
      'Cadastrar ninhada',
      () => pushNamed(context, Routes.CadastrarNinhada),
      context,
    );

    var appBar = ScaffoldCommonComponents.customAppBarWithDrawerAndAction(
        'Ninhada', Icons.add, () => pushNamed(context, Routes.CadastrarNinhada),);

    var drawer = CustomDrawer();

    var body = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<NinhadaModel>>(
        stream: _bloc.list.stream,
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
                  return ListTile(
                    subtitle: Text('Status: Aguardando aprovação'),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                           //TODO: Implement ninhada view
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
                    leading: Text(
                      ninhada.categoria.especie,
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
    );

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      drawer: drawer,
      body: body,
    );
  }
}
