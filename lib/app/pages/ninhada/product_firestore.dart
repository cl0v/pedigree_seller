import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/store_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/product_model.dart';

class ProductFirestore {
  ProductFirestore(this.storeId);

  static final String collectionPath = 'products';

  final String storeId;

  final _ref = FirebaseFirestore.instance
      .collection(collectionPath)
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromSnap(snapshot),
        toFirestore: (model, _) => model.toMap(),
      );

  CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection(collectionPath);


  Stream<List<Product>> get readAll => _ref
      .where(Product.pStoreId, isEqualTo: storeId)
      .snapshots()
      .map((p) => p.docs.map((e) => e.data()).toList());

  //TODO: Estudar o collection.withConverter
  Future<bool> create(
    Foto foto,
    Product p,
  ) async {
    try {
      await _ref.add(p).then((r) async => await _uploadFoto(r, foto, 'foto', Product.pImgUrl));
      
      //TODO: Salvar a foto dentro da pasta de canil, para facilitar manutenção
      return true;
    } catch (e) {
      return false;
    }
  }

  _uploadFoto(
    DocumentReference docRef,
    Foto foto,
    String fileName,
    String field,
  ) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child(StoreFirestore.collectionPath)
        .child(storeId)
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
