import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

class ReprodutoresFirestore {
  static CollectionReference<Map<String, dynamic>> get collection => FirebaseFirestore.instance.collection('canil');

  static Stream<List<ReprodutorModel>> stream(String canilReferenceId) =>
      collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .snapshots()
          .map((snap) =>
              snap.docs.map((s) => ReprodutorModel.fromMap(s.data())).toList());

  static Future<bool> register(
    ReprodutorModel reprodutor,
    String canilReferenceId,
  ) async {
    try {
      
      await collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .add(reprodutor.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
