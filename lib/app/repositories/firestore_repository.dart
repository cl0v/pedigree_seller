import 'package:cloud_firestore/cloud_firestore.dart';

import '../interfaces/cloud_data_base_interface.dart';

    //TODO: Testar quando um id errado é informado

class FirestoreRepository implements ICloudDataBase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Map<String, dynamic>> get(String path, String id) async{
    var query = await firestore.collection(path).where('id', isEqualTo: id).limit(1).get();
    var map = query.docs.first.data();
    return map;
    //TODO: Testar novamente, mudei coisas
  }

  Future<DocumentReference<Map<String, dynamic>>> put(String path, Map<String, dynamic> map) async=>
     firestore.collection(path).add(map);
  
}
