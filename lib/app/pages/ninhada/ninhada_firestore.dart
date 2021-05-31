import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

class NinhadaFirestore {
  NinhadaFirestore(this.canilReferenceId);

  final String canilReferenceId;

  CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection('ninhadas');

      

  Stream<List<NinhadaModel>> get stream => collection
      .where('canilReferenceId', isEqualTo: canilReferenceId)
      .snapshots()
      .map((query) =>
          query.docs.map((snap) => NinhadaModel.fromMap(snap.data())).toList());

  /* Create */

  //TODO: Estudar o collection.withConverter
  Stream<List<PaiMaeItem>> fetchReprodutores(
    CategoriaAnimal categoria,
    bool macho,
  ) =>
      FirebaseFirestore.instance
          .collection('canil')
          .doc(canilReferenceId)
          .collection('reprodutores')
          .where('categoria', isEqualTo: categoria.toMap())
          .where('isMacho', isEqualTo: macho)
          .snapshots()
          .map(
            (snap) => snap.docs
                .map(
                  (e) => PaiMaeItem(
                    nome: e.data()['nome'],
                    specs: CategoriaAnimal.fromMap(e.data()['categoria']),
                    referenceId: e.reference.id,
                  ),
                )
                .toList(),
          );

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
      return true;
    } catch (e) {
      return false;
    }
  }

  static _uploadFoto(
    DocumentReference<Map<String, dynamic>> docRef,
    Foto foto,
    String fileName,
    String field,
  ) async {
    String path = 'ninhadas/${docRef.id}/$fileName${foto.nome}';
    var ref = FirebaseStorage.instance.ref(path);

    //https://pub.dev/packages/file_picker
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (kIsWeb) {
      await ref.putData(foto.fileUnit!, metadata).whenComplete(
          () async => await docRef.update({field: await ref.getDownloadURL()}));
    } else {
      await ref.putFile(File(foto.path!), metadata).whenComplete(
          () async => await docRef.update({field: await ref.getDownloadURL()}));
    }

    return true;
  }
}
