import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

import 'cadastrar_ninhada_screen.dart';

class NinhadaFirestore {
  static CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection('ninhadas');

  //TODO: Estudar o collection.withConverter
  static Stream<List<PaiMaeItem>> fetchPais(
    // EspecificacoesAnimalModel specs,
    bool macho, {
    required String canilReferenceId,
  }) =>
      FirebaseFirestore.instance
          .collection('canil')
          .doc(canilReferenceId)
          .collection('reprodutores')
          .where('isMacho', isEqualTo: macho)
          // .where('categoria', isEqualTo: specs.toMap())
          .snapshots()
          .map(
            (snap) => snap.docs
                .map(
                  (e) => PaiMaeItem(
                    nome: e.data()['nome'],
                    // specs: e.data()['categoria'],
                    referenceId: e.reference.id,
                  ),
                )
                .toList(),
          );

  static Future<bool> register(NinhadaModel ninhada) async {
    try {
      collection.add(ninhada.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
