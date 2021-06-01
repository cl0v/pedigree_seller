import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';

class CanilFirestore {
  final String userReferenceId;

  CanilFirestore(this.userReferenceId);

   CollectionReference<Map<String, dynamic>> get _canilCollection =>
      FirebaseFirestore.instance.collection('canil');

   Stream<CanilModel?> stream() => _canilCollection
      .where('donoReferencia', isEqualTo: userReferenceId)
      .snapshots()
      .map(
        (query) => query.docs
            .map((snap) => CanilModel.fromDocumentSnapshot(snap)..save())
            .first,
      );

   Future<CanilModel?> future() async {
    var c = await _canilCollection
        .where('donoReferencia', isEqualTo: userReferenceId)
        .get();
    if (c.size > 0) {
      return _canilCollection
          .where('donoReferencia', isEqualTo: userReferenceId)
          .get()
          .then((q) => CanilModel.fromDocumentSnapshot(q.docs.first));
    } else
      return null;
  }

   Future<CanilModel?> register(CanilModel canil) async {
    try {
      var reference = await _canilCollection.add(canil.toMap());
      canil = canil.copyWith(referenceId: reference.id)..save();
      return canil;
    } catch (e) {
      return null;
    }
  }
}
