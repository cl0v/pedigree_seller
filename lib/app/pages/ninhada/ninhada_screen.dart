import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/screen_size.dart';

import 'ninhada_bloc.dart';

class NinhadasScreen extends StatefulWidget {
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen>
    with AutomaticKeepAliveClientMixin<NinhadasScreen> {
  late final _bloc;

  bool _dataLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    CanilModel.get().then((c) {
      print('Inicializado ni');
      //Segunda vez que roda parece que ta vindo nullo, após sair do app
      if (c != null) {
        _bloc = NinhadaBloc(c);
        _bloc.subscribe();
        setState(() {
          _dataLoaded = true;
        });
      }
    });
  }

/* BUG: 
The following LateError was thrown while finalizing the widget tree:
LateInitializationError: Field '_bloc' has not been initialized.

When the exception was thrown, this was the stack:
dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 236:49
throw_
packages/pedigree_seller/app/pages/ninhada/ninhada_screen.dart 17:14
get [_bloc]
packages/pedigree_seller/app/pages/ninhada/ninhada_screen.dart 45:5
*/
  @override
  void dispose() {
    print('Dispensado ni');
    super.dispose();
    deactivate();
    _bloc.bloc.dispose();
  }

  ListTile ninhadaTile(NinhadaModel ninhada) {
    return ListTile(
      subtitle: Text(ninhada.categoria.especie),
      title: Text(
        ninhada.titulo,
      ),

//TODO: Implement ninhada view, e editar ninhada
      //       icon: Icon(Icons.adaptive.more),
    );
  }

  //TODO: Quando o canil nao está cadastrado fica no loading eterno
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = getSize(context);

    final noData = Center(
      child: Text('Nenhuma ninhada cadastrada'),
    );

    final error = Center(
      child: Text('Ocorreu um erro, por favor tente mais tarte'),
    );

    final loading = Center(
      child: CircularProgressIndicator(),
    );

    var body = _dataLoaded
        ? Container(
            height: size.height,
            width: size.width,
            child: StreamBuilder<List<NinhadaModel>>(
              stream: _bloc.bloc.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    var ninhadas = snapshot.data;
                    return ninhadas != null
                        ? ninhadas.isEmpty
                            ? noData
                            : ListView.builder(
                                itemCount: ninhadas.length,
                                itemBuilder: (context, index) {
                                  var ninhada = ninhadas[index];
                                  return ninhadaTile(ninhada);
                                },
                              )
                        : error;
                  case ConnectionState.waiting:
                    return loading;
                  default:
                    return error;
                }
              },
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
    final fab = FloatingActionButton.extended(
      heroTag: 'FabNinhada',
      onPressed: () {
        pushNamed(context, Routes.CadastrarNinhada);
      },
      label: Text('Nova Ninhada'),
      icon: Icon(Icons.add),
    );

    return Scaffold(
        floatingActionButton: fab,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: body);
  }
}
