import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/commons/commons.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_bloc.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

class ReprodutoresScreen extends StatefulWidget {
  @override
  _ReprodutoresScreenState createState() => _ReprodutoresScreenState();
}

class _ReprodutoresScreenState extends State<ReprodutoresScreen>
    with AutomaticKeepAliveClientMixin<ReprodutoresScreen> {
  late final _bloc;
  bool _dataLoaded = false;

  @override
  bool get wantKeepAlive => true;
  //TODO: Talvez esse want keep alive esteja trollando

  @override
  void initState() {
    super.initState();
    CanilModel.get().then((c) {
      print('Inicializado re');
      if (c != null) _bloc = ReprodutoresBloc(c);
      _bloc.init();
      setState(() {
        _dataLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    print('Dispensado re');
    super.dispose();
    deactivate();
    _bloc.bloc.dispose();
  }

  _buildPetTile(Reprodutor pet) => ListTile(
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var body = _dataLoaded
        ? StreamBuilder<List<Reprodutor>>(
            stream: _bloc.bloc.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  var petList = snapshot.data;
                  if (petList != null) {
                    if (petList.isEmpty)
                      return noData;
                    else
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 72),
                        itemCount: petList.length,
                        itemBuilder: (context, index) {
                          var pet = petList[index];
                          return _buildPetTile(pet);
                        },
                      );
                  }
                  return loadingError;
                case ConnectionState.waiting:
                  return loading;
                default:
                  return loadingError;
              }
            })
        : Center(
            child: CircularProgressIndicator(),
          );

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FabReprodutor',
        onPressed: () {
          pushNamed(context, Routes.CadastrarReprodutor);
        },
        label: Text('Novo Reprodutor'),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: body,
    );
  }
}
