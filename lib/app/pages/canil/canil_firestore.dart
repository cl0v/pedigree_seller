import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';

class CanilFirestore {
  static CollectionReference<Map<String, dynamic>> get canilCollection =>
      FirebaseFirestore.instance.collection('canil');

  static Stream<CanilModel?> stream(String userReferenceId) => canilCollection
      .where('donoReferencia', isEqualTo: userReferenceId)
      .snapshots()
      .map(
        (query) => query.docs
            .map((snap) => CanilModel.fromDocumentSnapshot(snap)..save())
            .first,
      );

  static Future<CanilModel?> future(String userReferenceId) async {
    var c = await canilCollection
        .where('donoReferencia', isEqualTo: userReferenceId)
        .get();
    if (c.size > 0) {
      return canilCollection
          .where('donoReferencia', isEqualTo: userReferenceId)
          .get()
          .then((q) => CanilModel.fromDocumentSnapshot(q.docs.first));
    } else
      return null;
  }

  static Future<CanilModel?> register(titulo, contato, cnpj, userReferenceId) async {
    try {
      CanilModel canil = CanilModel(
        titulo: titulo,
        contato: contato,
        cnpj: cnpj,
        donoReferencia: userReferenceId,
      );

      var reference = await canilCollection.add(canil.toMap());
      canil = canil.copyWith(referenceId: reference.id)..save();
      return canil;
    } catch (e) {
      return null;
    }
  }
}
