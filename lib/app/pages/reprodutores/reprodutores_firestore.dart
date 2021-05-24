//Se voce chegou até aqui é certeza que ja possui um user e um canil cadastrados

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/repositories/firestore_repository.dart';

//TODO: Adicionar os dogs no banco de dados depois que estiver pronto a conexao c o server;
class ReprodutoresFirestore {
  static FirestoreRepository _repository = FirestoreRepository();

  Stream<List<ReprodutorModel>> get stream => FirebaseFirestore.instance
      .collection('canil')
      .doc('TUp0NvyJxb4AZvEUMDEf')
      .collection('reprodutores')
      .snapshots()
      .map((snap) => snap.docs.map((s) => ReprodutorModel.fromMap(s.data())).toList());

  static Future<List<ReprodutorModel>> get() async {
    var canil = (await CanilModel.get())!;

    var a = await _repository.getAll('reprodutores', canil.donoID, 'donoId');
    var list = a.map((e) => ReprodutorModel.fromMap(e.data())).toList();
    return list;
  }

  static Future<bool> register(
    nome,
    categoria,
    isMacho,
  ) async {
    try {
      ReprodutorModel reprodutorModel =
          ReprodutorModel(nome: nome, categoria: categoria, isMacho: isMacho);
      //TODO: Substituir para canilReference (Assim que implementar referencias);
      FirebaseFirestore.instance
          .collection('canil')
          .doc('TUp0NvyJxb4AZvEUMDEf')
          .collection('reprodutores')
          .add(reprodutorModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
