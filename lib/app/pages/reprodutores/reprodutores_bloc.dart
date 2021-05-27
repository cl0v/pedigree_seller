import 'dart:io';

import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class ReprodutoresBloc {
  final reprodutores = SimpleBloc<List<ReprodutorModel>>();
  final registerBtn = SimpleBloc<bool>();

  sub() async {
    var canil = await CanilModel.get();
    if (canil != null)
      reprodutores
          .subscribe(ReprodutoresFirestore.stream(canil.referenceId));
    else {
      print('Canil nao registrado, algo deu errado!');
    }
  }

  Future<bool> register(nome, categoria, isMacho, File file) async {
    registerBtn.add(true);

    var canil = await CanilModel.get();
    if (canil != null) {
      ReprodutorModel reprodutorModel = ReprodutorModel(
        nome: nome,
        categoria: categoria,
        isMacho: isMacho,
      );
      var response = await ReprodutoresFirestore.register(
          reprodutorModel, canil.referenceId, file);

      registerBtn.add(false);
      return response;
    }
    print('Nao foi possivel cadastrar');
    return false;
  }
}
