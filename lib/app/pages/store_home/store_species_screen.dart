import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/custom_date_picker_widget.dart';
import 'package:pedigree_seller/app/components/custom_drop_down_button_widget.dart';
import 'package:pedigree_seller/app/pages/store_home/store_pet_parents_registration_screen.dart';
import 'package:pedigree_seller/constants.dart';

//TODO: Meu trabalho será pesquisar as informacoes de cada dog separadamente
//FOTO dos pais
//Cores disponiveis
//Dia do nascimento

class StoreSpeciesController {
  //
  List<String> fetchPetSpeciesList([String? petCategory]) {
    return ['Pet', 'TwoPet', 'fori', 'fire'];
  }
}

class StoreSpeciesScreen extends StatefulWidget {
  @override
  _StoreSpeciesScreenState createState() => _StoreSpeciesScreenState();
}

class _StoreSpeciesScreenState extends State<StoreSpeciesScreen> {
  final controller = StoreSpeciesController();
  late var _petList;
  @override
  void initState() {
    super.initState();
    _petList = controller.fetchPetSpeciesList();
  }

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
          'Especie',
          style: kTitleTextStyle,
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.pop(context),
          );
        }),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            //TODO: Data de nascimento do filhote
            CustomDatePicker(),
            //TODO: Lista de especies
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomDropDownButtonWidget(
                list: _petList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomAppBar _bottomAppBar(Size size, BuildContext context) => BottomAppBar(
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
            title: 'Avançar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StorePetParentsRegistration(),
                ),
              );
            },
          ),
        ),
      );
}
