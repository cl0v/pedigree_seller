import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';

class RegisterController {
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

  register() {
    emailPreenchido = emailController.text != '';
    nomePreenchido = nomeController.text != '';
    telefonePreenchido = telefoneController.text != '';
    cpfPreenchido = cpfController.text != '';
    senhaPreenchido = senhaController.text != '';
    confirmarSenhaPreenchido = confirmarSenhaController.text != '';
    confirmed = true;
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

//TODO: A forma que estou pondo aqui é exatamente a forma de meu cel
//Pode ser que de erro em outros celulares

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ScaffoldCommonComponents.customAppBarWithoutIcons('Cadastrar'),
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              TextInputFieldWidget(
                icon: Icons.email,
                hint: 'Email',
                inputAction: TextInputAction.next,
                inputType: TextInputType.emailAddress,
                controller: controller.emailController,
              ),
              controller.confirmed && !controller.emailPreenchido
                  ? errorText
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.person,
                hint: 'Nome',
                inputAction: TextInputAction.next,
                controller: controller.nomeController,
              ),
              controller.confirmed && !controller.nomePreenchido
                  ? errorText
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.phone,
                hint: 'Telefone',
                inputAction: TextInputAction.next,
                inputType: TextInputType.phone,
                controller: controller.telefoneController,
              ),
              controller.confirmed && !controller.telefonePreenchido
                  ? errorText
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.credit_card,
                hint: 'CPF',
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                controller: controller.cpfController,
              ),
              controller.confirmed && !controller.cpfPreenchido
                  ? errorText
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.lock,
                hint: 'Senha',
                inputAction: TextInputAction.next,
                isObscure: true,
                controller: controller.senhaController,
              ),
              controller.confirmed && !controller.senhaPreenchido
                  ? errorText
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.lock,
                hint: 'Confirmar senha',
                inputAction: TextInputAction.done,
                isObscure: true,
                controller: controller.confirmarSenhaController,
              ),
              controller.confirmed && !controller.confirmarSenhaPreenchido
                  ? errorText
                  : Container(),
              SizedBox(
                height: size.height * 0.05,
              ),
              //TODO: Implement state button
              CustomButtonWidget(
                  title: 'Register',
                  onPressed: () => setState(() => controller.register())),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text('Já tem uma conta? Entrar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
