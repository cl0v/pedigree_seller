import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
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
    required Foto pedigreeFile,
  }) async {
    try {
      final docRef = await collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .add(reprodutor.toMap());

      var suffix = p.extension(pedigreeFile.nome);

      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

      String path =
          // 'canil/$canilReferenceId/reprodutores/${docRef.id}/pedigree_certificate';
          'canil/$canilReferenceId/reprodutores/${docRef.id}/pedigree_certificate$suffix';
      var ref = FirebaseStorage.instance.ref(path);

      //https://pub.dev/packages/file_picker
      if (kIsWeb) {
        await ref.putData(pedigreeFile.fileUnit!, metadata).whenComplete(
            () async => await docRef
                .update({'certificado': await ref.getDownloadURL()}));
      } else {
        await ref.putFile(File(pedigreeFile.path!), metadata).whenComplete(
            () async => await docRef
                .update({'certificado': await ref.getDownloadURL()}));
      }

      return true;
    } catch (e, ex) {
      print(ex);
      return false;
    }
  }
}
