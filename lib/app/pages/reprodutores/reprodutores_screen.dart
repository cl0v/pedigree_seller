import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_api.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

//TODO: Implement PetController

//TODO: Criar ReprodutorViewModel (Apenas o que é vizualizado do model ReprodutorModel)

class ReprodutoresController {
  Future<List<ReprodutorModel>> fetchReprodutores() async {
    return ReprodutoresApi.get(); //Atualizar quando volta pra cá
  }
}

class ReprodutoresScreen extends StatefulWidget {
  @override
  _ReprodutoresScreenState createState() => _ReprodutoresScreenState();
}

class _ReprodutoresScreenState extends State<ReprodutoresScreen> {
  final controller = ReprodutoresController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScaffoldCommonComponents.customBottomAppBar(
        'Cadastrar um Pet',
        () {
          pushNamed(context, Routes.CadastrarReprodutor);
        },
        context,
      ),
      appBar: ScaffoldCommonComponents.customAppBarWithDrawerAndAction(
        'Reprodutores',
        Icons.add,
        () {
          pushNamed(context, Routes.CadastrarReprodutor);
        },
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<ReprodutorModel>>(
          future: controller.fetchReprodutores(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                var petList = snapshot.data!;
                if (petList.isEmpty)
                  return Center(
                    child: Text('Nenhum cadastrado ainda'),
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
          }),
    );
  }
}
