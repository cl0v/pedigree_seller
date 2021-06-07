import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

class Store {
  static final String pId = 'id';
  static final String pTitle = 'title';
  static final String pPhone = 'phone';
  static final String pInstagram = 'instagram';
  static final String pUserId = 'userId';
  //TODO:Adicionar instagram

  String id;
  String title;
  String phone;
  String instagram;
  String userId;

  Store({
    required this.title,
    required this.phone,
    required this.instagram,
    this.userId = '',
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return {
      pTitle: title,
      pPhone: phone,
      pInstagram: instagram,
      pUserId: userId,
    };
  }

  Map<String, dynamic> toMapWithReference() {
    return {
      pId: id,
      pTitle: title,
      pPhone: phone,
      pInstagram: instagram,
      pUserId: userId,
    };
  }

  factory Store.fromMapWithReference(Map<String, dynamic> map) {
    return Store(
      title: map[pTitle],
      phone: map[pPhone],
      instagram: map[pInstagram],
      userId: map[pUserId],
      id: map[pId],
    );
  }

  factory Store.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Store.fromMap(snapshot.data()!)..id = snapshot.reference.id;

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      title: map[pTitle],
      phone: map[pPhone],
      instagram: map[pInstagram],
      userId: map[pUserId],
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMapWithReference(json.decode(source));

  static Future<Store?> get() async {
    final json = await Prefs.get('canil.prefs');
    if (json != null) return json.isEmpty ? null : Store.fromJson(json);
    return null;
  }

  save() {
    String json = jsonEncode(toMapWithReference());
    Prefs.put('canil.prefs', json);
  }

  static clear() {
    Prefs.put('canil.prefs', '');
  }



  Store copyWith({
    String? id,
    String? title,
    String? phone,
    String? instagram,
    String? userId,
  }) {
    return Store(
      id: id ?? this.id,
      title: title ?? this.title,
      phone: phone ?? this.phone,
      instagram: instagram ?? this.instagram,
      userId: userId ?? this.userId,
    );
  }
}
