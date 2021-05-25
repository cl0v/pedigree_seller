import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_drawer_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var future = UserModel.get();

    // var body = ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: CircleImage(),
    //     ),
    //     ListTile(
    //       title: Text('Nome:'),
    //       subtitle: Text(
    //         "Renato Ikeuchi",
    //       ),
    //     ),
    //     ListTile(
    //       title: Text('Email:'),
    //       subtitle: Text(
    //         'rntcursos@gmail.com',
    //       ),
    //     ),
    //     ListTile(
    //       title: Text('Contato:'),
    //       subtitle: Text(
    //         "+55 35 9 8416-4756",
    //       ),
    //     ),
    //     ListTile(
    //       title: Text('Endereço:'),
    //       subtitle: Text(
    //         "Rua Benjamin Constate 70 B - Centro - Cambuquira",
    //       ),
    //     ),
    //     const ListTile(
    //       title: Text('Sair'),
    //       subtitle: Text("Sair da minha conta"),
    //       trailing: Icon(Icons.exit_to_app),
    //     ),
    //   ],
    // );

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
              ListTile(
                title: Text('Email:'),
                subtitle: Text(
                  user.email,
                ),
              ),
              ListTile(
                title: Text('Contato:'),
                subtitle: Text(
                  user.contato,
                ),
              ),
              ListTile(
                title: Text('CPF:'),
                subtitle: Text(
                  '${user.cpf.substring(0, 3)}********',
                ),
              ),
              const ListTile(
                title: Text('Sair'),
                subtitle: Text("Sair da minha conta"),
                trailing: Icon(Icons.exit_to_app),
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
      appBar: ScaffoldCommonComponents.customAppBarWithDrawerWithoutAction(
        'Perfil',
      ),
      drawer: CustomDrawer(),
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
