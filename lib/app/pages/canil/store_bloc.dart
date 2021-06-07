import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/store_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/store_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class StoreBloc {
  StoreBloc(this.userId, {this.canil}) {
    bloc.add(canil);
  }

  final String userId;
  Store? canil;

  final createBtnBloc = SimpleBloc<bool>();
  final bloc = SimpleBloc<Store?>();

  StoreFirestore get _respository => StoreFirestore(userId);

  Future<Store?> create(Store s) async {
    //TODO: Receber o model
    createBtnBloc.add(true);
    var c = await _respository.register(s..userId = userId);
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
