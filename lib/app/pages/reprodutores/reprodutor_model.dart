import 'dart:convert';
import 'package:pedigree_seller/app/components/category_screen.dart';

class Reprodutor {
  String file;
  String certificado;
  String nome;
  bool isMacho;
  CategoriaAnimal categoria;

  Reprodutor({
    this.file = 'FileUrl',
    this.certificado = 'FileUrl',
    required this.nome,
    required this.categoria,
    required this.isMacho,
  });

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'certificado': certificado,
      'nome': nome,
      'isMacho': isMacho,
      'categoria': categoria.toMap(),
    };
  }

  factory Reprodutor.fromMap(Map<String, dynamic> map) {
    return Reprodutor(
      file: map['file'],
      certificado: map['certificado'],
      nome: map['nome'],
      isMacho: map['isMacho'],
      categoria: CategoriaAnimal.fromMap(map['categoria']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reprodutor.fromJson(String source) => Reprodutor.fromMap(json.decode(source));

}

class CategoriaAnimal {
  String categoria;
  String especie;
  CategoriaAnimal({
    required this.categoria,
    required this.especie,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'especie': especie,
    };
  }

  factory CategoriaAnimal.fromMap(Map<String, dynamic> map) {
    return CategoriaAnimal(
      categoria: map['categoria'],
      especie: map['especie'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriaAnimal.fromJson(String source) => CategoriaAnimal.fromMap(json.decode(source));
}


List<CategoriasEspecies> listaDeValores = [
  CategoriasEspecies(text: 'Cachorro', list: [
    CategoriasEspecies(text: 'Rotwailer'),
    CategoriasEspecies(text: 'Poodle'),
    CategoriasEspecies(text: 'Fila')
  ]),
  CategoriasEspecies(text: 'Gato', list: [
    CategoriasEspecies(text: 'Persa'),
    CategoriasEspecies(text: 'Chaninha'),
  ]),
  CategoriasEspecies(text: 'Coelho'),
];
