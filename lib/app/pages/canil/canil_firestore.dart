import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';

class CanilFirestore {
  static CollectionReference<Map<String, dynamic>> get canilCollection =>
      FirebaseFirestore.instance.collection('canil');

  static Future<CanilModel?> get() async {
    try {
      var canil = await CanilModel.get();
      if (canil != null) {
        print('Canil>> $canil');
        return canil;
      }
      var user = (await UserModel.get())!;

      var query = await canilCollection
          .where('donoReferencia', isEqualTo: user.referenceId)
          .limit(1)
          .get();

      var reference = query.docs.first;

      if (reference.exists) {
        canil = CanilModel.fromDocumentSnapshot(reference);
        canil.save();
        return canil;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> register(titulo, contato, cnpj) async {
    try {
      UserModel? user = await UserModel.get();
      if (user != null) {
        CanilModel canil = CanilModel(
          titulo: titulo,
          contato: contato,
          cnpj: cnpj,
          donoReferencia: user.referenceId,
        );

        var reference = await canilCollection.add(canil.toMap());
        canil = canil.copyWith(referenceId: reference.id)..save();
        return true;
      } else
        return true;
    } catch (e) {
      return false;
    }
  }
}
