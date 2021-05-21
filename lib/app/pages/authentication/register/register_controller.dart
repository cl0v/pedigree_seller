import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';

class RegisterController {
  BuildContext context;
  RegisterController({
    required this.context,
  });

  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  bool confirmed = false;
  bool emailPreenchido = false;
  bool nomePreenchido = false;
  bool telefonePreenchido = false;
  bool cpfPreenchido = false;
  bool senhaPreenchido = false;
  bool confirmarSenhaPreenchido = false;

  _registrar() async {
    //TODO: Connect registrar
    pushReplacement(context, Routes.Home);
  }

  onAlreadyHasAccountPressed() {
    popUntil(context, Routes.Login);
  }

  verifyRegister() async {
    emailPreenchido = emailController.text != '';
    nomePreenchido = nomeController.text != '';
    telefonePreenchido = telefoneController.text != '';
    cpfPreenchido = cpfController.text != '';
    senhaPreenchido = senhaController.text != '';
    confirmarSenhaPreenchido = confirmarSenhaController.text != '';
    confirmed = true;
    await _registrar();
  }
}
