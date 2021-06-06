import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/product_model.dart';

class NinhadaFirestore {
  NinhadaFirestore(this.canilReferenceId);

  static final String collectionPath = 'products';

  final String canilReferenceId;

  CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection(collectionPath);

  Stream<List<Product>> get stream => collection
      .where(Product.pStoreId, isEqualTo: canilReferenceId)
      .
      //   .withConverter<NinhadaModel>(
      //     fromFirestore: (json) => NinhadaModel.fromMap(json.data()!),
      //    toFirestore: (model) => model.toMap(),
      //  ).
      snapshots()
      .map((query) =>
          query.docs.map((snap) => Product.fromMap(snap.data())).toList());

  Stream<List<Product>> get streamWithConverter => collection
      .where(Product.pStoreId, isEqualTo: canilReferenceId)
      .
      //   .withConverter<NinhadaModel>(
      //     fromFirestore: (json) => NinhadaModel.fromMap(json.data()!),
      //    toFirestore: (model) => model.toMap(),
      //  ).
      snapshots()
      .map((query) =>
          query.docs.map((snap) => Product.fromMap(snap.data())).toList());
  /* Create */

  //TODO: Estudar o collection.withConverter
  Future<bool> register(
    Foto foto,
    Product ninhada,
  ) async {
    try {
      Map<String, dynamic> map = ninhada.toMap()
        ..addEntries([
          MapEntry(Product.pApproved, false),
        ]);

      var ref = await collection.add(map);
      await _uploadFoto(ref, foto, 'foto', Product.pImgUrl);
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
    var ref = FirebaseStorage.instance
        .ref()
        .child(CanilFirestore.collectionPath)
        .child(canilReferenceId)
        .child(collectionPath)
        .child(docRef.id)
        .child(foto.nome);

    //https://pub.dev/packages/file_picker
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (kIsWeb) {
      await ref.putData(foto.fileUnit!, metadata).whenComplete(() async {
        await docRef.update({field: await ref.getDownloadURL()});
      });
    } else {
      await ref.putFile(File(foto.path!), metadata).whenComplete(
          () async => await docRef.update({field: await ref.getDownloadURL()}));
    }
  }
}
