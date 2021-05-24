import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_bloc.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class ReprodutoresScreen extends StatefulWidget {
  @override
  _ReprodutoresScreenState createState() => _ReprodutoresScreenState();
}

class _ReprodutoresScreenState extends State<ReprodutoresScreen> {
  final _bloc = ReprodutoresBloc();

  @override
  void initState() {
    super.initState();
    _bloc.sub();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.reprodutores.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = ScaffoldCommonComponents.customAppBarWithDrawerAndAction(
      'Reprodutores',
      Icons.add,
      () {
        pushNamed(context, Routes.CadastrarReprodutor);
      },
    );

    var drawer = CustomDrawer();

    var body = StreamBuilder<List<ReprodutorModel>>(
        stream: _bloc.reprodutores.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              var petList = snapshot.data!;
              if (petList.isEmpty)
                return Center(
                  child: Text('Nenhum cadastrado ainda\nToque para cadastrar'),
                );
              else
                return ListView.builder(
                  itemCount: petList.length,
                  itemBuilder: (context, index) {
                    var pet = petList[index];
                    return ListTile(
                      // leading: Icon(Icons.mars),
                      trailing: IconButton(
                        icon: Icon(Icons.adaptive.more),
                        onPressed: () {
                          //TODO: OnTap para editar
                          //Mostrar um popupmenubutton com as opçoes de editar, deletar, (Add arquivar), etc;
                        },
                      ),
                      subtitle: Text(pet.categoria.especie),
                      title: Text(pet.nome),
                    );
                  },
                );
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Center(
                child: Text('Ocorreu um erro, tente novamente mais tarde'),
              );
          }
        });

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: body,
    );
  }
}
