import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                height: size.width * 0.1,
              ),
              Text(
                'Cadastrar',
                style: TextStyle(
                  color: Colors.red.withOpacity(.8),
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              TextInputFieldWidget(
                icon: Icons.email,
                hint: 'Email',
                inputAction: TextInputAction.next,
              ),
              TextInputFieldWidget(
                  icon: Icons.person,
                  hint: 'Nome',
                  inputAction: TextInputAction.next),
              TextInputFieldWidget(
                  icon: Icons.lock,
                  hint: 'Senha',
                  inputAction: TextInputAction.next),
              TextInputFieldWidget(
                  icon: Icons.lock,
                  hint: 'Confirmar senha',
                  inputAction: TextInputAction.done),
              SizedBox(
                height: size.height * 0.05,
              ),
              //TODO: Implement state button
              CustomButtonWidget(title: 'Register', onPressed: () {}),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Text('Já tem uma conta? Entrar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
