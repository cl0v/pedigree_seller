import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    final AppBar appBar =
        ScaffoldCommonComponents.customAppBarWithoutIcons('Loja');

    final List<Widget> children = [
      //TODO: Recriar botoes para ir para as paginas 
      ElevatedButton(
          onPressed: () {
            pushNamed(context, Routes.Reprodutores);
          },
          child: Text('Reprodutores')),
      ElevatedButton(onPressed: () {
            pushNamed(context, Routes.Ninhada);

      }, child: Text('Ninhadas')),
    ];

    final Widget body = Column(
      children: children,
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
