import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class CanilBloc {
  var canil = SimpleBloc<CanilModel?>();
  var canilCreate = SimpleBloc<bool>();

  fetchCanil() async {
    canil.add(await CanilFirestore.get());
  }

  Future<bool> create(titulo, contato, cnpj) async {
    canilCreate.add(true);
    var response = await CanilFirestore.register(titulo, contato, cnpj);
    canilCreate.add(false);
    return response;
  }

}
