import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/commons/commons.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_bloc.dart';

class ReprodutoresScreen extends StatefulWidget {
  @override
  _ReprodutoresScreenState createState() => _ReprodutoresScreenState();
}

class _ReprodutoresScreenState extends State<ReprodutoresScreen>
    with AutomaticKeepAliveClientMixin<ReprodutoresScreen> {
  final _bloc = ReprodutoresBloc();

  @override
  bool get wantKeepAlive => true;

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

  _buildPetTile(ReprodutorModel pet) => ListTile(
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

    var body = StreamBuilder<List<ReprodutorModel>>(
        stream: _bloc.reprodutores.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              var petList = snapshot.data;
              if (petList != null) {
                if (petList.isEmpty)
                  return noData;
                else
                  return ListView.builder(
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
        });

    return Scaffold(
      // appBar: appBar,
      body: body,
    );
  }
}
