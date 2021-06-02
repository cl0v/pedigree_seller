import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';

class NinhadaFirestore {
  NinhadaFirestore(this.canilReferenceId);

  final String canilReferenceId;

  CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection('ninhadas');

  Stream<List<NinhadaModel>> get stream => collection
      .where('canilReferenceId', isEqualTo: canilReferenceId).
    //   .withConverter<NinhadaModel>(
    //     fromFirestore: (json) => NinhadaModel.fromMap(json.data()!),
    //    toFirestore: (model) => model.toMap(),
    //  ).
      snapshots()
      .map((query) =>
          query.docs.map((snap) => NinhadaModel.fromMap(snap.data())).toList());

  Stream<List<NinhadaModel>> get streamWithConverter => collection
      .where('canilReferenceId', isEqualTo: canilReferenceId).
    //   .withConverter<NinhadaModel>(
    //     fromFirestore: (json) => NinhadaModel.fromMap(json.data()!),
    //    toFirestore: (model) => model.toMap(),
    //  ).
      snapshots()
      .map((query) =>
          query.docs.map((snap) => NinhadaModel.fromMap(snap.data())).toList());
  /* Create */

  //TODO: Estudar o collection.withConverter
  Future<bool> register(
    Foto foto,
    NinhadaModel ninhada,
  ) async {
    try {
      Map<String, dynamic> map = ninhada.toMap()
        ..addEntries([
          MapEntry('approved', false),
        ]);

      var ref = await collection.add(map);
      await _uploadFoto(ref, foto, 'foto', 'img');
      //TODO: Salvar a foto dentro da pasta de canil, para facilitar manutenção
      return true;
    } catch (e) {
      return false;
    }
  }

  _uploadFoto(
    DocumentReference<Map<String, dynamic>> docRef,
    Foto foto,
    String fileName,
    String field,
  ) async {
    // String path = //TODO: Alterar o nome do arquivo e deixar o nome original
    //     'canil/$canilReferenceId/ninhadas/${docRef.id}/$fileName${foto.nome}';
    var ref = FirebaseStorage.instance
        .ref()
        .child('canil')
        .child(canilReferenceId)
        .child('ninhadas')
        .child(docRef.id)
        .child(foto.nome);

    //https://pub.dev/packages/file_picker
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (kIsWeb) {
      await ref.putData(foto.fileUnit!, metadata).whenComplete(() async {
        print( await ref.getDownloadURL());
        await docRef.update({field: await ref.getDownloadURL()});
      });
    } else {
      await ref.putFile(File(foto.path!), metadata).whenComplete(
          () async => await docRef.update({field: await ref.getDownloadURL()}));
    }

    return true;
  }
}
