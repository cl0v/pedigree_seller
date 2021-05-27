import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

class ReprodutoresFirestore {
  static CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection('canil');

  static Stream<List<ReprodutorModel>> stream(
          String canilReferenceId) =>
      collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .snapshots()
          .map((snap) =>
              snap.docs.map((s) => ReprodutorModel.fromMap(s.data())).toList());

  static Future<bool> register(
    ReprodutorModel reprodutor,
    String canilReferenceId,
    File file,
  ) async {
    try {
      final docRef = await collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .add(reprodutor.toMap());

      String? imgUrl = await _fileUpload(file, canilReferenceId, docRef.id);

      await docRef.update({'certificado': imgUrl});

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> _fileUpload(
      File file, String canilReference, String docReference) async {
        //TODO: Corrigir error que faz retornar nulo
    final ref = FirebaseStorage.instance
        .ref()
        .child('canil')
        .child('/$canilReference')
        .child('/reprodutores')
        .child('/$docReference')
        .child('/pedigree_certificate.jpg');
    var uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() async {
      return ref.getDownloadURL();
    });
  }
}
