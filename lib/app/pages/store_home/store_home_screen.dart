import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';
import 'package:pedigree_seller/app/pages/store_home/store_species_screen.dart';
import 'package:pedigree_seller/constants.dart';

//TODO
/*
 - Categoria: Cachorro
 - Especie: rotwailer, bulldog
*/

enum PetCategory {
  Cat,
  Dog,
  Hamster,
  Rabbit,
}

class StoreHomeScreen extends StatefulWidget {
  @override
  _StoreHomeScreenState createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
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
          'Cadastrar',
          style: kTitleTextStyle,
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.grey[800],
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        
      ),
      //TODO: Estudar como botar o singleChildScrollView
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Column(
              children: [
                TextInputFieldWidget(
                  icon: Icons.title,
                  hint: 'Titulo da ninhada',
                ),
                TextInputFieldWidget(
                  icon: Icons.add,
                  hint: 'Quantidade de filhos',
                ),

                //TODO: Adicionar lista de categorias
                TextInputFieldWidget(
                  hint: 'Valor',
                  padding: EdgeInsets.only(top: 8),
                  prefixWidget: Radio(
                    //TODO: Tentar remover o padding automatico do radio
                    value: false,
                    groupValue: [],
                    onChanged: (v) {},
                  ),
                ),
              ],
            ),
            

            //TODO: Criar um dropdown com o mesmo esquema desse textfield
            // RadioListTile(
            //   value: false,
            //   groupValue: [],
            //   onChanged: (val) {},
            //   title: Text('Gato'),
            // ),
            // RadioListTile(
            //   value: false,
            //   groupValue: [],
            //   onChanged: (val) {},
            //   title: Text('Cachorro'),
            // ),
            // RadioListTile(
            //   value: false,
            //   groupValue: [],
            //   onChanged: (val) {},
            //   title: Text('Rato'),
            // ),
            // RadioListTile(
            //   value: false,
            //   groupValue: [],
            //   onChanged: (val) {},
            //   title: Text('Coelho'),
            // ),
            //TODO: Adicionar icone de avançar no botao
          ],
        ),
      ),
    );
  }

  BottomAppBar _bottomAppBar(Size size, BuildContext context) {
    return BottomAppBar(
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
                builder: (context) => StoreSpeciesScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FieldWidget extends StatelessWidget {
  final Widget child;
  const FieldWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
