import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/form_error_text.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_bloc.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/alert.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _bloc = RegisterBloc();
  final _tEmail = TextEditingController(text: 'marcelo.ita.boss@gmail.com'); //text: 'marcelo.ita.boss@gmail.com'
  final _tNome = TextEditingController(text: 'marcelo'); //text: 'marcelo'
  final _tContato = TextEditingController(text: '73932146147'); //text: '73932146147'
  final _tCpf = TextEditingController(text: '09841232606'); //text: '09841232606'
  final _tSenha = TextEditingController(text: '..sdidasd..'); //text: '..sdidasd..'
  final _tConfSenha = TextEditingController(text: '..sdidasd..'); //text: '..sdidasd..'

  bool _showError = false;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _onRegisterPressed() async {
    if (!(_validateEmail() == null &&
        _validateNome() == null &&
        _validateContato() == null &&
        _validateCpf() == null &&
        _validateSenha() == null)) {
      setState(() {
        _showError = true;
      });
      return;
    }
    setState(() {
      _showError = false;
    });

    String email = _tEmail.text;
    String nome = _tNome.text;
    String contato = _tContato.text;
    String cpf = _tCpf.text;
    String senha = _tSenha.text;

    //TODO: Procurar uma forma de simplificar para nao cair em erros;

    var response = await _bloc.register(email, senha, cpf, nome, contato);

    if (response)
      pushNamed(context, Routes.Home, replace: true);
    else
      alert(context, 'Error na criação de conta!');
  }

  _onBackToLoginPressed() {
    pop(context);
  }

  String? _validateEmail() {
    var text = _tEmail.text;
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String? _validateNome() {
    //TODO: Implement
    var text = _tNome.text;
    if (text.isEmpty) {
      return "Digite o nome";
    }
    return null;
  }

  String? _validateContato() {
    //TODO: Implement
    var text = _tContato.text;
    if (text.isEmpty) {
      return "Digite o telefone";
    }
    return null;
  }

  String? _validateCpf() {
    //TODO: Implement
    var text = _tCpf.text;
    if (text.isEmpty) {
      return "Digite o cpf";
    }
    return null;
  }

  String? _validateSenha() {
    var text = _tSenha.text;
    var conf = _tConfSenha.text;
    if (text.isEmpty || conf.isEmpty) {
      return "Digite a senha";
    }
    if (text != conf) {
      return "Precisam ser iguais";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var registerBtn = StreamBuilder(
        stream: _bloc.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return CustomButtonWidget(
            'Register',
            onPressed: _onRegisterPressed,
            showProgress: snapshot.data ?? false,
          );
        });

    var backBtn = Center(
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
                  ..onTap = _onBackToLoginPressed),
          ],
        ),
      ),
    );

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
                controller: _tEmail,
              ),
              _validateEmail() != null && _showError
                  ? FormErrorText(_validateEmail()!)
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.person,
                hint: 'Nome',
                inputAction: TextInputAction.next,
                controller: _tNome,
              ),
              _validateNome() != null && _showError
                  ? FormErrorText(_validateNome()!)
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.phone,
                hint: 'Telefone',
                inputAction: TextInputAction.next,
                inputType: TextInputType.phone,
                controller: _tContato,
              ),
              _validateContato() != null && _showError
                  ? FormErrorText(_validateContato()!)
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.credit_card,
                hint: 'CPF',
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                controller: _tCpf,
              ),
              _validateCpf() != null && _showError
                  ? FormErrorText(_validateCpf()!)
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.lock,
                hint: 'Senha',
                inputAction: TextInputAction.next,
                isObscure: true,
                controller: _tSenha,
              ),
              _validateSenha() != null && _showError
                  ? FormErrorText(_validateSenha()!)
                  : Container(),
              TextInputFieldWidget(
                icon: Icons.lock,
                hint: 'Confirmar senha',
                inputAction: TextInputAction.done,
                isObscure: true,
                controller: _tConfSenha,
              ),
              _validateSenha() != null && _showError
                  ? FormErrorText(_validateSenha()!)
                  : Container(),
              SizedBox(
                height: size.height * 0.05,
              ),
              //
              registerBtn,
              SizedBox(
                height: 10,
              ),
              backBtn,
            ],
          ),
        ),
      ),
    );
  }
}
