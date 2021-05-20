import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/models/reprodutores_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

//TODO: Implement PetController

class ReprodutoresController {
  List<ReprodutorModel> petList = [];

  Future<List<ReprodutorModel>> fetchReprodutores() async {
    //TODO: Implement fetchReprodutores
    return petList;
  }
}

class ReprodutoresScreen extends StatefulWidget {
  @override
  _ReprodutoresScreenState createState() => _ReprodutoresScreenState();
}

class _ReprodutoresScreenState extends State<ReprodutoresScreen> {
  final controller = ReprodutoresController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScaffoldCommonComponents.customBottomAppBar(
        'Cadastrar um Pet',
        () async {
          ReprodutorModel? valor =
              await pushNamed(context, Routes.CadastrarReprodutor);
          if (valor != null)
            setState(() {
              controller.petList.add(valor);
            });
        },
        context,
      ),
      appBar: ScaffoldCommonComponents.customAppBarWithDrawer(
        'Reprodutores',
        Icons.add,
        () async {
          ReprodutorModel? valor =
              await pushNamed(context, Routes.CadastrarReprodutor);
          if (valor != null)
            setState(() {
              controller.petList.add(valor);
            });
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
                        subtitle: Text(pet.categoria.especie!),
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
