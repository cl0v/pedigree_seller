import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

class ReprodutoresFirestore {
  static CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection('canil');

  static Stream<List<Reprodutor>> stream(String canilReferenceId) => collection
      .doc(canilReferenceId)
      .collection('reprodutores')
      .snapshots()
      .map((snap) =>
          snap.docs.map((s) => Reprodutor.fromMap(s.data())).toList());

  static Future<bool> register({
    required Reprodutor reprodutor,
    required String canilReferenceId,
    required File pedigreeFile,
  }) async {
    try {
      final docRef = await collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .add(reprodutor.toMap());

//TDOO:Criar o path dentro do storage, depois que existir, tentar salvar, se nao vai continuar bugando
      List<String> allowedExtensions = ['.jpg', '.jpeg', '.png'];
      var suffix = '.jpg';
      allowedExtensions.any((ext) {
        if (pedigreeFile.path.endsWith(ext)) suffix = ext;
        return pedigreeFile.path.endsWith(ext);
      });

      String path =
          'canil/$canilReferenceId/reprodutores/${docRef.id}/pedigree_certificate$suffix';
      var ref = FirebaseStorage.instance.ref(path);
      ref.putFile(pedigreeFile).whenComplete(() async => await docRef.update({'certificado': await ref.getDownloadURL()}));
      //     .child('canil/$canilReferenceId/reprodutores/${docRef.id}');

      // var ref = FirebaseStorage.instance.ref(path).child(path).putFile(pedigreeFile);
      // print('MEtadata $ref');
      // await ref.putFile(pedigreeFile);

      //Testar se ele é o donwload url

      return true;
    } catch (e, ex) {
      print(ex);
      return false;
    }
  }

  static Future<String?> _fileUpload(File file, String path) async {
    //TODO: Corrigir error que faz retornar nulo
    try {
      FirebaseStorage.instance.ref(path).putFile(file);
      return path;
    } on FirebaseException catch (e, ex) {
      print('Expection : $ex');
    }
  }
}
