import 'dart:convert';

import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

class CanilModel {
  String titulo;
  String contato;
  String cnpj;
  String donoID;
  // DocumentReference? reference; //TODO: Implementar e testar referencia;
  CanilModel({
    required this.titulo,
    required this.contato,
    required this.cnpj,
    this.donoID = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'contato': contato,
      'cnpj': cnpj,
      'donoID': donoID,
    };
  }

  factory CanilModel.fromMap(Map<String, dynamic> map) {
    return CanilModel(
      titulo: map['titulo'],
      contato: map['contato'],
      cnpj: map['cnpj'],
      donoID: map['donoID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CanilModel.fromJson(String source) =>
      CanilModel.fromMap(json.decode(source));

  static Future<CanilModel?> get() async {
    final json = await Prefs.get('canil.prefs');
    if (json != null) return json.isEmpty ? null : CanilModel.fromJson(json);
    return null;
  }

  save() {
    String json = toJson();
    Prefs.put('canil.prefs', json);
  }

  static clear() {
    Prefs.put('canil.prefs', '');
  }
}
