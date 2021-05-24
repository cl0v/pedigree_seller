import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

class CanilModel {
  String titulo;
  String contato;
  String cnpj;
  String donoReferencia;
  String referenceId;
  CanilModel({
    required this.titulo,
    required this.contato,
    required this.cnpj,
    this.donoReferencia = '',
    this.referenceId = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'contato': contato,
      'cnpj': cnpj,
      'donoReferencia': donoReferencia,
    };
  }

  Map<String, dynamic> toMapWithReference() {
    return {
      'titulo': titulo,
      'contato': contato,
      'cnpj': cnpj,
      'donoReferencia': donoReferencia,
      'referenceId': referenceId
    };
  }

  factory CanilModel.fromMapWithReference(Map<String, dynamic> map) {
    return CanilModel(
      titulo: map['titulo'],
      contato: map['contato'],
      cnpj: map['cnpj'],
      donoReferencia: map['donoReferencia'],
      referenceId: map['referenceId'],
    );
  }

  factory CanilModel.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      CanilModel.fromMap(snapshot.data()!)
          .copyWith(referenceId: snapshot.reference.id);

  factory CanilModel.fromMap(Map<String, dynamic> map) {
    return CanilModel(
      titulo: map['titulo'],
      contato: map['contato'],
      cnpj: map['cnpj'],
      donoReferencia: map['donoReferencia'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CanilModel.fromJson(String source) =>
      CanilModel.fromMapWithReference(json.decode(source));

  static Future<CanilModel?> get() async {
    final json = await Prefs.get('canil.prefs');
    if (json != null) return json.isEmpty ? null : CanilModel.fromJson(json);
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
    return 'CanilModel(titulo: $titulo, contato: $contato, cnpj: $cnpj, donoID: $donoReferencia, referenceId: $referenceId)';
  }

  CanilModel copyWith({
    String? titulo,
    String? contato,
    String? cnpj,
    String? donoID,
    String? referenceId,
  }) {
    return CanilModel(
      titulo: titulo ?? this.titulo,
      contato: contato ?? this.contato,
      cnpj: cnpj ?? this.cnpj,
      donoReferencia: donoID ?? this.donoReferencia,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
