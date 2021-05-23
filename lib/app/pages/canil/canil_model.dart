import 'dart:convert';

import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

class CanilModel {
  //Lista de ninhadas
  String titulo;
  String contato;
  String cnpj;
  String dataCadastro;
  String donoID; //Trocar mais tarde por referencia
  List<String> ninhadasReferencia;
  List<String> reprodutoresReferencia;
  CanilModel({
    required this.titulo,
    required this.contato,
    required this.cnpj,
    this.dataCadastro = '',
    this.donoID = '',
    this.ninhadasReferencia = const [],
    this.reprodutoresReferencia = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'contato': contato,
      'cnpj': cnpj,
      'dataCadastro': dataCadastro,
      'donoID': donoID,
      'ninhadasReferencia': ninhadasReferencia,
      'reprodutoresReferencia': reprodutoresReferencia,
    };
  }

  factory CanilModel.fromMap(Map<String, dynamic> map) {
    return CanilModel(
      titulo: map['titulo'],
      contato: map['contato'],
      cnpj: map['cnpj'],
      dataCadastro: map['dataCadastro'],
      donoID: map['donoID'],
      ninhadasReferencia: List<String>.from(map['ninhadasReferencia']),
      reprodutoresReferencia: List<String>.from(map['reprodutoresReferencia']),
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

final CanilModel canilMocked = CanilModel(
  titulo: 'titulo',
  contato: 'contato',
  cnpj: 'cnpj',
  dataCadastro: 'dataCadastro',
  donoID: 'donoID',
  ninhadasReferencia: ['ninhadasReferencia'],
  reprodutoresReferencia: ['reprodutoresReferencia'],
);
