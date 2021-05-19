import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';

push(BuildContext context, Widget page) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

pushNamed(BuildContext context, String route) =>
    Navigator.pushNamed(context, route);

back(BuildContext context) => Navigator.pop(context);

backToHome(BuildContext context) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
    ModalRoute.withName('/'));
