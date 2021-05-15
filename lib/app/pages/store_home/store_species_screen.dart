import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';

class StoreSpeciesScreen extends StatefulWidget {
  @override
  _StoreSpeciesScreenState createState() => _StoreSpeciesScreenState();
}

class _StoreSpeciesScreenState extends State<StoreSpeciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
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
      ),
    );
  }
}
