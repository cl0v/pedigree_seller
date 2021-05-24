import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/form_error_text.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_bloc.dart';
import 'package:pedigree_seller/app/utils/alert.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/app/utils/screen_size.dart';

class CreateCanilScreen extends StatefulWidget {
  @override
  _CreateCanilScreenState createState() => _CreateCanilScreenState();
}

class _CreateCanilScreenState extends State<CreateCanilScreen> {
  final _tNome = TextEditingController(text: 'Canil');
  final _tContato = TextEditingController(text: 'Canil');
  final _tCnpj = TextEditingController(text: 'Canil');

  final _bloc = CanilBloc();

  bool _showError = false;

  @override
  void dispose() {
    super.dispose();
    _bloc.createBtn.dispose();
  }

  _onCreatePressed() async {
    if (!(_validateNome() == null &&
        _validateContato() == null &&
        _validateCnpj() == null)) {
      setState(() {
        _showError = true;
      });
      return;
    }
    setState(() {
      _showError = false;
    });

    String nome = _tNome.text;
    String contato = _tContato.text;
    String cnpj = _tCnpj.text;

    var response = await _bloc.create(nome, contato, cnpj);

    if (response)
      pop(context);
    else
      alert(context, 'Error na criação de conta!');
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

  String? _validateCnpj() {
    //TODO: Implement
    var text = _tCnpj.text;
    if (text.isEmpty) {
      return "Digite o cnpj";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);

    var appBar = ScaffoldCommonComponents.customAppBar(
      'Cadastrar canil',
      () {
        pop(context);
      },
    );

    var bottomButton = BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.1,
          0,
          size.width * 0.1,
          8,
        ),
        child: StreamBuilder(
          stream: _bloc.createBtn.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return CustomButtonWidget(
              'Register',
              onPressed: _onCreatePressed,
              showProgress: snapshot.data ?? false,
            );
          },
        ),
      ),
    );

    var body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        children: [
          TextInputFieldWidget(
            icon: Icons.store,
            hint: 'Titulo',
            inputAction: TextInputAction.next,
            controller: _tNome,
          ),
          _validateNome() != null && _showError
              ? FormErrorText(_validateNome()!)
              : Container(),
          TextInputFieldWidget(
            icon: Icons.phone,
            hint: 'Contato',
            inputAction: TextInputAction.next,
            inputType: TextInputType.phone,
            controller: _tContato,
          ),
          _validateContato() != null && _showError
              ? FormErrorText(_validateContato()!)
              : Container(),
          TextInputFieldWidget(
            icon: Icons.document_scanner,
            hint: 'CNPJ',
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            controller: _tCnpj,
          ),
          _validateCnpj() != null && _showError
              ? FormErrorText(_validateCnpj()!)
              : Container(),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomButton,
      body: body,
    );
  }
}
