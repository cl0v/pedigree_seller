import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

const canilPath = 'canil';

class FirebaseAnimalRepository {
  static final _firebase = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> fetchNinhadas() async {
    var result =
        await _firebase.collection(canilPath).doc('EEui2tKlxw1wb6wkCwxc').get();
    List ninhadaList = result.data()!['ninhadas'];

    List<Map<String, dynamic>> lista = [];

    for (var n in ninhadaList) {
      DocumentReference a = n;
      var b = await a.get();
      print(jsonEncode(b.data()));
      lista.add(b.data() as Map<String, dynamic>);
      // ninhadasMap.add(n.data()!);
    }

    return lista;
  }
}
