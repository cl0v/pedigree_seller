import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

class ReprodutoresFirestore {
  static Stream<List<ReprodutorModel>> getStream(String canilReferenceId) =>
      FirebaseFirestore.instance
          .collection('canil')
          .doc(canilReferenceId)
          .collection('reprodutores')
          .snapshots()
          .map((snap) =>
              snap.docs.map((s) => ReprodutorModel.fromMap(s.data())).toList());

  static Future<bool> register(
    String nome,
    categoria,
    bool isMacho,
    String canilReferenceId,
  ) async {
    try {
      ReprodutorModel reprodutorModel =
          ReprodutorModel(nome: nome, categoria: categoria, isMacho: isMacho);
      FirebaseFirestore.instance
          .collection('canil')
          .doc(canilReferenceId)
          .collection('reprodutores')
          .add(reprodutorModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
