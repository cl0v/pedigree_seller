import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';


class NinhadaFirestore {
  static CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection('ninhadas');

  static Stream<List<NinhadaModel>> stream(String canilReferenceId) =>
      collection
          .where('canilReferenceId', isEqualTo: canilReferenceId)
          .snapshots()
          .map((query) => query.docs
              .map((snap) => NinhadaModel.fromMap(snap.data()))
              .toList());

  /* Create */

  //TODO: Estudar o collection.withConverter
  static Stream<List<PaiMaeItem>> fetchReprodutores(
          CategoriaAnimal categoria, bool macho,
          {required String canilReferenceId}) =>
      FirebaseFirestore.instance
          .collection('canil')
          .doc(canilReferenceId)
          .collection('reprodutores')
          .where('categoria', isEqualTo: categoria.toMap())
          .where('isMacho', isEqualTo: macho)
          .snapshots()
          .map(
            (snap) => snap.docs
                .map(
                  (e) => PaiMaeItem(
                    nome: e.data()['nome'],
                    specs: CategoriaAnimal.fromMap(
                        e.data()['categoria']),
                    referenceId: e.reference.id,
                  ),
                )
                .toList(),
          );

  static Future<bool> register(NinhadaModel ninhada) async {
    try {
      Map<String, dynamic> map = ninhada.toMap()
        ..addEntries([
          MapEntry('approved', false),
        ]);
      collection.add(map);
      return true;
    } catch (e) {
      return false;
    }
  }
}
