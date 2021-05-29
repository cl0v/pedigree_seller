import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_bloc.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/screen_size.dart';

class NinhadasScreen extends StatefulWidget {
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen>
    with AutomaticKeepAliveClientMixin<NinhadasScreen> {
  final _bloc = NinhadaBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _bloc.list.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.subscribe();
    //TODO: Ta dando algum bug quando entra na página, ai nao ta carregando
  }

  ListTile ninhadaTile(NinhadaModel ninhada) {
    return ListTile(
      subtitle: Text(ninhada.categoria.especie),
      title: Text(
        ninhada.titulo,
      ),
      // leading: Text('ATIVO'),
      // trailing: Wrap(
      //   spacing: 12,
      //   children: [
      //     IconButton(
      //       icon: Icon(Icons.remove_red_eye),
      //       onPressed: () {
      //         //TODO: Implement ninhada view
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.adaptive.more),
      //       onPressed: () {
      //         //Mostrar um popupmenubutton com as opçoes de editar, deletar, (Add arquivar), etc;
      //       },
      //     ),

      //   ],
      // ),
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

    var body = Container(
      height: size.height,
      width: size.width,
      child: StreamBuilder<List<NinhadaModel>>(
        stream: _bloc.list.stream,
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
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FabNinhada',
        onPressed: () {
          pushNamed(context, Routes.CadastrarNinhada);
        },
        label: Text('Nova Ninhada'),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: body,
    );
  }
}
