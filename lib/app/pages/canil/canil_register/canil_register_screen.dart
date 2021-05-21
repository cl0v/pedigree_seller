import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/models/canil_model.dart';
import 'package:pedigree_seller/app/pages/canil/viewmodel/canil_view_model.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

import '../../../../constants.dart';

//TODO: Criar formulario para registro de canil

class CanilController {
  BuildContext context;
  CanilController({
    required this.context,
  });

  TextEditingController nomeController = TextEditingController();
  TextEditingController contatoController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();

  bool isConfirmed = false;
  bool isNomePreenchido = false;
  bool isContatoPreenchido = false;
  bool isCnpjPreenchido = false;

  onCadastrarPressed() {
    isConfirmed = true;
    isNomePreenchido = nomeController.text != '';
    isContatoPreenchido = contatoController.text != '';
    isCnpjPreenchido = cnpjController.text != '';
    CanilModel canil = CanilModel(
      titulo: nomeController.text,
      contato: contatoController.text,
      cnpj: cnpjController.text,
    );
    if (isNomePreenchido && isContatoPreenchido && isCnpjPreenchido)
      pop(
        context,
        CanilViewModel(titulo: canil.titulo),
      );
  }
}

class CanilRegisterScreen extends StatefulWidget {
  @override
  _CanilRegisterScreenState createState() => _CanilRegisterScreenState();
}

class _CanilRegisterScreenState extends State<CanilRegisterScreen> {
  late final controller;

  @override
  void initState() {
    super.initState();
    controller = CanilController(context: context);
  }

  showError(bool condition) {
    return condition ? errorText : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldCommonComponents.customAppBar(
        'Cadastrar',
        () => pop(context),
      ),
      bottomNavigationBar:
          ScaffoldCommonComponents.customBottomAppBar('Cadastrar', () {
        setState(() {
          controller.onCadastrarPressed();
        });
      }, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            TextInputFieldWidget(
              icon: Icons.store,
              hint: 'Titulo',
              inputAction: TextInputAction.next,
              controller: controller.nomeController,
            ),
            showError(controller.isConfirmed && !controller.isNomePreenchido),
            TextInputFieldWidget(
              icon: Icons.phone,
              hint: 'Contato',
              inputAction: TextInputAction.next,
              inputType: TextInputType.phone,
              controller: controller.contatoController,
            ),
            showError(controller.isConfirmed && !controller.isContatoPreenchido),
            TextInputFieldWidget(
              icon: Icons.document_scanner,
              hint: 'CNPJ',
              inputAction: TextInputAction.next,
              inputType: TextInputType.number,
              controller: controller.cnpjController,
            ),
            showError(controller.isConfirmed && !controller.isCnpjPreenchido),
          ],
        ),
      ),
    );
  }
}
