import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

class Store {
  static final String pId = 'id';
  static final String pTitle = 'title';
  static final String pPhone = 'phone';
  static final String pCnpj = 'cnpj';
  static final String pUserId = 'userId';

  String id;
  String title;
  String phone;
  String cnpj;
  String userId;
  Store({
    required this.title,
    required this.phone,
    required this.cnpj,
    this.userId = '',
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return {
      pTitle: title,
      pPhone: phone,
      pCnpj: cnpj,
      pUserId: userId,
    };
  }

  Map<String, dynamic> toMapWithReference() {
    return {
      pTitle: title,
      pPhone: phone,
      pCnpj: cnpj,
      pUserId: userId,
      pId: id
    };
  }

  factory Store.fromMapWithReference(Map<String, dynamic> map) {
    return Store(
      title: map[pTitle],
      phone: map[pPhone],
      cnpj: map[pCnpj],
      userId: map[pUserId],
      id: map[pId],
    );
  }

  factory Store.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Store.fromMap(snapshot.data()!)
          .copyWith(referenceId: snapshot.reference.id);

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      title: map[pTitle],
      phone: map[pPhone],
      cnpj: map[pCnpj],
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

  @override
  String toString() {
    return 'CanilModel(titulo: $title, contato: $phone, cnpj: $cnpj, donoID: $userId, referenceId: $id)';
  }

  Store copyWith({
    String? titulo,
    String? contato,
    String? cnpj,
    String? donoID,
    String? referenceId,
  }) {
    return Store(
      title: titulo ?? this.title,
      phone: contato ?? this.phone,
      cnpj: cnpj ?? this.cnpj,
      userId: donoID ?? this.userId,
      id: referenceId ?? this.id,
    );
  }
}
