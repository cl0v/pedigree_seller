import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class CanilBloc {
  CanilBloc(this.user, {this.canil}) {
    bloc.add(canil);
  }

  final UserModel user;
  CanilModel? canil;

  final createBtnBloc = SimpleBloc<bool>();
  final bloc = SimpleBloc<CanilModel?>();

  CanilFirestore get _respository => CanilFirestore(user.referenceId);

  Future<CanilModel?> create(CanilModel canil) async {
    //TODO: Receber o model
    createBtnBloc.add(true);
    var c =
        await _respository.register(canil.copyWith(donoID: user.referenceId));
    createBtnBloc.add(false);

    return c;
  }

  Future<CanilModel?> get() async {
    var c = await CanilModel.get();
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
