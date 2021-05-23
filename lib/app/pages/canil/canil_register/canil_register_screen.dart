import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_api.dart';
import 'package:pedigree_seller/app/pages/canil/model/canil_model.dart';
import 'package:pedigree_seller/app/pages/canil/viewmodel/canil_view_model.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';

import '../../../../constants.dart';

//TODO: Criar formulario para registro de 

//TODO: Adicionar reprodutores num banco local

class CanilController {
  BuildContext context;
  CanilController({
    required this.context,
  });

  TextEditingController nomeController = TextEditingController(text: 'Canil');
  TextEditingController contatoController =
      TextEditingController(text: 'Canil');
  TextEditingController cnpjController = TextEditingController(text: 'Canil');

  bool isConfirmed = false;
  bool isNomePreenchido = false;
  bool isContatoPreenchido = false;
  bool isCnpjPreenchido = false;

  onCadastrarPressed() async {
    isConfirmed = true;
    isNomePreenchido = nomeController.text != '';
    isContatoPreenchido = contatoController.text != '';
    isCnpjPreenchido = cnpjController.text != '';
    if (isNomePreenchido && isContatoPreenchido && isCnpjPreenchido) {
      CanilModel canil = CanilModel(
        titulo: nomeController.text,
        contato: contatoController.text,
        cnpj: cnpjController.text,
      );
      try {
        await CanilApi.register(canil);
        pop(
          context,
          CanilViewModel(titulo: canil.titulo),
        );
      } catch (e) {
        print(e);
      }
    }
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
        () {
          popUntil(context, Routes.Canil);
        },
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
            showError(
                controller.isConfirmed && !controller.isContatoPreenchido),
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
