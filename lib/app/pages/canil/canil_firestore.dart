import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/store_model.dart';

class CanilFirestore {
  final String userReferenceId;

  CanilFirestore(this.userReferenceId);

  static final String collectionPath = 'stores';

  CollectionReference<Map<String, dynamic>> get _canilCollection =>
      FirebaseFirestore.instance.collection(collectionPath);

  //TODO: Implement withConverter

  Stream<Store?> stream() => _canilCollection
      .where(Store.pUserId, isEqualTo: userReferenceId)
      .snapshots()
      .map(
        (query) => query.docs
            .map((snap) => Store.fromDocumentSnapshot(snap)..save())
            .first,
      );

  Future<Store?> future() async {
    var c = await _canilCollection
        .where(Store.pUserId, isEqualTo: userReferenceId)
        .get();
    if (c.size > 0) {
      return _canilCollection
          .where(Store.pUserId, isEqualTo: userReferenceId)
          .get()
          .then((q) => Store.fromDocumentSnapshot(q.docs.first));
    } else
      return null;
  }

  Future<Store?> register(Store canil) async {
    try {
      var reference = await _canilCollection.add(canil.toMap());
      canil = canil.copyWith(referenceId: reference.id)..save();
      return canil;
    } catch (e) {
      return null;
    }
  }
}
