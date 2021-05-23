import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_api.dart';
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
    var email = emailController.text;
    var nome = nomeController.text;
    var telefone = telefoneController.text;
    var cpf = cpfController.text;
    var senha = senhaController.text;

    var user = await RegisterApi.register(
      email,
      senha,
      User(
        cpf: cpf,
        nome: nome,
        email: email,
        contato: telefone,
      ),
    );

    if (user != null) pushNamed(context, Routes.Home, replace: true);
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
    if (senhaController.text ==
        confirmarSenhaController
            .text) if (emailPreenchido &&
        nomePreenchido &&
        telefonePreenchido &&
        cpfPreenchido &&
        senhaPreenchido &&
        confirmarSenhaPreenchido) await _registrar();
  }
}
