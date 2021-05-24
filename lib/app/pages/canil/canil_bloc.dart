import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class CanilBloc {
  var createBtn = SimpleBloc<bool>();

  Future<bool> create(titulo, contato, cnpj) async {
    createBtn.add(true);
    var response = await CanilFirestore.register(titulo, contato, cnpj);
    createBtn.add(false);

    return response;
  }

  var canil = SimpleBloc<CanilModel?>();

  sub() async {
    var user = await UserModel.get();
    var c = await CanilModel.get();
    if (c != null) {
      canil.add(c);
    } else if (user != null) {
      canil.subscribe(CanilFirestore.stream(user.referenceId));
    } else {
      print('Nenhum user cadastrado, deu erro');
    }
  }

}
