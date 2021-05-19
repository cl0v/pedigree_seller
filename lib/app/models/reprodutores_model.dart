
//TODO: Foi o que criei agora porra
import 'dart:convert';

import 'package:pedigree_seller/app/models/raca_model.dart';

class ReprodutorModel {
  String file;
  String certificado;
  String nome;
  Raca categoria;
  bool isMacho;

  ReprodutorModel({
    this.file = 'FileUrl',
    this.certificado = 'FileUrl',
    required this.nome,
    required this.categoria,
    required this.isMacho,
  });

  @override
  String toString() {
    return 'ReprodutoresModel(file: $file, certificado: $certificado, nome: $nome, categoria: ${categoria.toString()}, isMacho: $isMacho)';
  }

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'certificado': certificado,
      'nome': nome,
      'categoria': categoria.toMap(),
      'isMacho': isMacho,
    };
  }

  factory ReprodutorModel.fromMap(Map<String, dynamic> map) {
    return ReprodutorModel(
      file: map['file'],
      certificado: map['certificado'],
      nome: map['nome'],
      categoria: Raca.fromMap(map['categoria']),
      isMacho: map['isMacho'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReprodutorModel.fromJson(String source) => ReprodutorModel.fromMap(json.decode(source));
}


final m1 = ReprodutorModel(
  nome: 'Vagabunda',
  categoria: Raca(category: 'Cachorro', especie: 'Hamster'),
  isMacho: false,
);
final m2 = ReprodutorModel(
  nome: 'Lora',
  categoria: Raca(category: 'Cachorro', especie: 'Hamster'),
  isMacho: false,
);
final p1 = ReprodutorModel(
  nome: 'Vagabund',
  categoria: Raca(category: 'Cachorro', especie: 'Hamster'),
  isMacho: true,
);
final p2 = ReprodutorModel(
  nome: 'Popo',
  categoria: Raca(category: 'Cachorro', especie: 'Hamster'),
  isMacho: true,
);
