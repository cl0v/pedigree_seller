import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/model/canil_model.dart';
import 'package:pedigree_seller/app/repositories/firestore_repository.dart';

class CanilApi {
  static FirestoreRepository _repository = FirestoreRepository();

  static Future<CanilModel?> get() async {
    var user = (await UserModel.get())!;
    var canil = await CanilModel.get(); //Se nao tiver cadastrado no Shared
    if (canil == null) {
      var a = await _repository.get(
        'canil',
        user.id!,
        whereField: 'donoID'
      ); //Se nao tiver cadastrado no Servidor
      
      if (a != null)
        return CanilModel.fromMap(a)..save();
      else
        return null;
    } else {
      return canil;
    }
  }

  static register(CanilModel canil) async {
    UserModel user = (await UserModel.get())!;
    canil.donoID = user.id!;
    try {
      await _repository.put('canil', canil.toMap());
      return canil..save();
    } catch (e, ex) {
      print(e);
      throw ex;
    }
  }
}
