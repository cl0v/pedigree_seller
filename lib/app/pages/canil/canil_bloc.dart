import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/store_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class CanilBloc {
  CanilBloc(this.user, {this.canil}) {
    bloc.add(canil);
  }

  final UserModel user;
  Store? canil;

  final createBtnBloc = SimpleBloc<bool>();
  final bloc = SimpleBloc<Store?>();

  CanilFirestore get _respository => CanilFirestore(user.referenceId);

  Future<Store?> create(Store canil) async {
    //TODO: Receber o model
    createBtnBloc.add(true);
    var c =
        await _respository.register(canil.copyWith(donoID: user.referenceId));
    createBtnBloc.add(false);

    return c;
  }

  Future<Store?> get() async {
    var c = await Store.get();
    if (c == null) {
      c = await _respository.future();
      //Tenho uma stream la, posso bindar
      if (c != null) {
        c.save();
      }
    }
    bloc.add(c);
    return c;
  }
}
