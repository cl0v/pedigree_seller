import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class ReprodutoresBloc {
  final list = SimpleBloc<List<ReprodutorModel>>();
  final registerBtn = SimpleBloc<bool>();

  subToStream() async {
    var canil = await CanilModel.get();
    if (canil != null)
      list.subscribe(ReprodutoresFirestore.getStream(canil.referenceId));
    else {
      print('Canil nao registrado, algo deu errado!');
    }
  }

  Future<bool> register(nome, categoria, isMacho) async {
    registerBtn.add(true);

    var canil = await CanilModel.get();
    if (canil != null) {
      var response = await ReprodutoresFirestore.register(
          nome, categoria, isMacho, canil.referenceId);

      registerBtn.add(false);
      return response;
    }
    return false;
  }

}
