import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/home/home_screen.dart';

push(BuildContext context, Widget page, {bool replace = true}) {
  if (replace)
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  else
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

pushNamed(BuildContext context, String route, {bool replace = true}) {
  if (replace)
    Navigator.pushReplacementNamed(context, route);
  else
    Navigator.pushNamed(context, route);
}

popUntil(BuildContext context, String route) =>
    Navigator.popUntil(context, ModalRoute.withName(route));

pop(BuildContext context, [result]) => Navigator.pop(context, result);

backToHome(BuildContext context) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
    ModalRoute.withName('/'));
