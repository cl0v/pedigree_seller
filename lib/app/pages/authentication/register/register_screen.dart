import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_controller.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final controller;
  @override
  void initState() {
    super.initState();
    controller = RegisterController(context: context);
  }

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
              //
              CustomButtonWidget(
                title: 'Register',
                onPressed: ()async {
                  var r = await controller.verifyRegister();
                  setState(
                  () => r,
                );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: kBodyTextStyle,
                    children: [
                      TextSpan(
                        text: 'Já tem uma conta?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: ' Entrar',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.onAlreadyHasAccountPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
