import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_screen.dart';
import 'package:pedigree_seller/constants.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin<StoreScreen> {
  late final _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Loja',
        style: kTitleTextStyle,
      ),
      bottom: TabBar(
        controller: _tabController,
        labelColor: Colors.black,
        tabs: [
          //TODO: aba de ativos
          // Tab(
          //   text: "Ativos",
          // ),
          Tab(
            text: "Ninhadas",
          ),
          Tab(
            text: "Reprodutores",
          ),
        ],
      ),
    );

    final List<Widget> children = [
      //TODO: Recriar botoes para ir para as paginas
      // NinhadasScreen(),//TODO: Criar ativos
      NinhadasScreen(),
      ReprodutoresScreen(),
    ];

    final Widget body = TabBarView(
      controller: _tabController,
      children: children,
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
