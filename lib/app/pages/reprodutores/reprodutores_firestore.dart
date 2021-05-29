import 'dart:io';

import 'package:flutter/foundation.dart';
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
    required Foto foto,
    required Reprodutor reprodutor,
    required String canilReferenceId,
    required Foto fotoCertificado,
  }) async {
    try {
      final docRef = await collection
          .doc(canilReferenceId)
          .collection('reprodutores')
          .add(reprodutor.toMap());

      await _uploadFoto(
        canilReferenceId,
        docRef,
        fotoCertificado,
        'pedigree_certificate',
        'certificado'
      );
      await _uploadFoto(
        canilReferenceId,
        docRef,
        foto,
        'file',
        'file',
      );

      return true;
    } catch (e, ex) {
      print(ex);
      return false;
    }
  }

  static _uploadFoto(
      String canilReferenceId,
      DocumentReference<Map<String, dynamic>> docRef,
      Foto foto,
      String fileName,
      String field,) async {
    String path =
        'canil/$canilReferenceId/reprodutores/${docRef.id}/$fileName${foto.nome}';
    var ref = FirebaseStorage.instance.ref(path);

    //https://pub.dev/packages/file_picker
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (kIsWeb) {
      await ref.putData(foto.fileUnit!, metadata).whenComplete(
          () async => await docRef
              .update({field: await ref.getDownloadURL()}));
    } else {
      await ref.putFile(File(foto.path!), metadata).whenComplete(
          () async => await docRef
              .update({field: await ref.getDownloadURL()}));
    }

    return true;
  }
}
