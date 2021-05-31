import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

/*
  O que acontece no caso em que o usuario cria uma conta, mas nao loga, ou sai do 
    app assim que cria a conta?
 - Vai ter o user User.get
 - Não vai ter canil 

*/
/*
 Splash:
 - Tem user e canil => Home
 - Tem user, mas não tem canil => Cadastrar canil
 - Nao tem user, (nao pode ter canil os dois saem juntos) => Login
*/

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    UserModel.get().then((user) {
      if (user != null) {
        pushNamed(context, Routes.Home, replace: true);
      } else {
        pushNamed(context, Routes.Login, replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
