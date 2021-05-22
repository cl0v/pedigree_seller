import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _myGridItem(
      String gridName, Color color1, Color color2, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
            begin: Alignment.centerLeft,
            end: Alignment(1.0, 1.0),
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: .3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //     gridImage,
                  //   ),
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    gridName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//TODO: Na home vai ter algumas metricas
//TODO: Pedir email e nome da pessoa que clicar no botao para ligar (Unica forma
// de mensurar o inicio do app antes de fechar o pagamento e o chat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldCommonComponents.customAppBarWithDrawerAndAction(
        'Home',
        Icons.notifications_none,
        () {},
      ),
      drawer: CustomDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        childAspectRatio: 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          _myGridItem('Meus animais', Colors.green, Colors.blue, () {
            pushNamed(context, Routes.Reprodutores);
          }),
          _myGridItem('Ninhadas', Colors.pink, Colors.blue, () {
            push(context, NinhadasScreen());
          }),
          _myGridItem('Historico de vendas', Colors.red, Colors.blue, () {}),
          _myGridItem('Dashboard ', Colors.purple, Colors.blue, () {}),
        ],
      ),
    );
  }
}

class HomeTitleSectionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const HomeTitleSectionWidget({
    Key? key,
    this.title = "Encontre seu",
    this.subtitle = "Novo filhote",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}

AppBar _appBar(context) {
  return AppBar(
    brightness: Brightness.light,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.sort,
        color: Colors.grey[800],
      ),
      onPressed: () => Scaffold.of(context).openDrawer(),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 16),
        child: Icon(
          Icons.notifications_none,
          color: Colors.grey[800],
        ),
      ),
    ],
  );
}
