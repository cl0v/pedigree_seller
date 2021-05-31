import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class CanilBloc {
  final createBtnBloc = SimpleBloc<bool>();
  final bloc = SimpleBloc<CanilModel?>();

  final UserModel user;
  CanilModel? canil; //Quando for nulo, preciso procurar

//TODA vez que é chamado ele cria um novo bloc, obviamente
  CanilBloc(this.user, {this.canil}) {
    bloc.add(canil);
  }

  Future<CanilModel?> create(titulo, contato, cnpj) async {
    createBtnBloc.add(true);
    var c =
        await CanilFirestore.register(titulo, contato, cnpj, user.referenceId);
    bloc.add(c);
    createBtnBloc.add(false);

    return c;
  }

  Future<CanilModel?> get() async {
    var c = await CanilModel.get();
    if (c == null) {
      c = await CanilFirestore.future(user.referenceId);
      if (c != null) {
        c.save();
      }
    }
    print('Valor do c: $c');
    bloc.add(c);
    return c;
  }
}
