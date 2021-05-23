//Se voce chegou até aqui é certeza que ja possui um user e um canil cadastrados

import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_model.dart';
import 'package:pedigree_seller/app/repositories/firestore_repository.dart';

//TODO: Adicionar os dogs no banco de dados depois que estiver pronto a conexao c o server;
class ReprodutoresApi {
  static FirestoreRepository _repository = FirestoreRepository();

  static Future<List<ReprodutorModel>> get() async {
    var canil = (await CanilModel.get())!;
    var a = await _repository.getAll('reprodutores', canil.donoID, 'donoId');
    var list = a.map((e) => ReprodutorModel.fromMap(e.data())).toList();
    return list;
  }

  static register(ReprodutorModel reprodutor) async {
    try {
      await _repository.put('reprodutores', reprodutor.toMap());
      return reprodutor;
    } catch (e, ex) {
      print(e);
      throw ex;
    }
  }
}
