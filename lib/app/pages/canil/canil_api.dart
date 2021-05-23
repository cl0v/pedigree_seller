import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/repositories/firestore_repository.dart';

class CanilApi {
  static FirestoreRepository _repository = FirestoreRepository();

  static Future<CanilModel?> get() async {
    try {
      var canil = await CanilModel.get();
      if (canil != null) return canil;
      var user = (await UserModel.get())!;
      var response = await _repository.get(
        'canil',
        user.id!,
        whereField: 'donoID',
      );
      if (response != null) return CanilModel.fromMap(response)..save();
      return null;
    } catch (e) {
      return null;
    }
  }

  static register(titulo, contato, cnpj) async {
    try {
      UserModel user = (await UserModel.get())!;
      CanilModel canil = CanilModel(
          titulo: titulo, contato: contato, cnpj: cnpj, donoID: user.id!);
      await _repository.put('canil', canil.toMap());
      canil.save();
      return true;
    } catch (e) {
      return false;
    }
  }
}
