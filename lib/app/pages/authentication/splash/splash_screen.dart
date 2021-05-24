import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/authentication_firestore.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

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
