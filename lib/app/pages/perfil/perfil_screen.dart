import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  var future = UserModel.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = ScaffoldCommonComponents.customAppBarWithoutIcons(
      'Perfil',
    );

    var fBuilder = FutureBuilder<UserModel?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel user = snapshot.data!;
          return ListView(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: CircleImage(),
              // ),
              ListTile(
                title: Text('Nome:'),
                subtitle: Text(
                  user.nome,
                ),
              ),
              Divider(),
              
              ListTile(
                title: Text('Email:'),
                subtitle: Text(
                  user.email,
                ),
              ),
              Divider(),
              ListTile(
                
                title: Text('Contato:'),
                subtitle: Text(
                  user.contato,
                ),
              ),
              Divider(),
              ListTile(
                title: Text('CPF:'),
                subtitle: Text(
                  '${user.cpf.substring(0, 3)}********',
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.store),
                title: Text('Dados da loja:'),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                  'Acessar loja',
                ),
                onTap: () {
                  pushNamed(context, Routes.Canil);
                },
              ),
              Divider(),
              ListTile(
                title: Text('Sair'),
                subtitle: Text("Sair da minha conta"),
                leading: Icon(Icons.exit_to_app),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  UserModel.clear();
                  CanilModel.clear();
                  pushNamed(context, Routes.Login, replace: true);
                },
                //TODO: Passar o sair para cá futuramente(Sair da drawer)
              ),
            ],
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );

    var result = Scaffold(
      appBar: appBar,
      body: fBuilder,
    );

    return result;
  }
}

class CircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        width: 180.0,
        height: 180.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://via.placeholder.com/150'),
          ),
        ),
      ),
    );
  }
}
