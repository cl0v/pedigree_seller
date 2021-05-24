import 'package:cloud_firestore/cloud_firestore.dart';

import '../interfaces/cloud_data_base_interface.dart';

//TODO: Testar quando um id errado é informado

class FirestoreRepository implements ICloudDataBase { //TODO: Renomeadar para ICloudNoSql
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Map<String, dynamic>?> get(String path, String id,
      {String whereField = 'id'}) async {
    try {
      var query = await firestore
          .collection(path)
          .where(whereField, isEqualTo: id)
          .limit(1)
          .get();
      var first = query.docs.first;
      var map = first.exists ? first.data() : null;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> put(
          String path, Map<String, dynamic> map) async =>
      firestore.collection(path).add(map);

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAll(
      String path, String id, String whereField) async {
    try {
      var query = await firestore
          .collection(path)
          .where(whereField, isEqualTo: id)
          .get();
      return query.docs;
    } catch (e) {
      return [];
    }
  }
}
