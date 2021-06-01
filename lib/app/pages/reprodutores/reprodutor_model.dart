import 'dart:convert';
import 'package:pedigree_seller/app/components/category_screen.dart';
import 'package:pedigree_seller/app/components/drop_down_button_widget.dart';

class Reprodutor extends DropDownItem {
  String img;
  // String certificado; //TODO: Remover certificado obrigatorio
  //bool isPure? isPedigree? isCertificated?
  String nome;
  bool isMacho;
  CategoriaAnimal categoria;
  //TODO: Implementar referencia

  Reprodutor({
    this.img = 'img',
    // this.certificado = 'img',
    required this.nome,
    required this.categoria,
    required this.isMacho,
  });

  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'nome': nome,
      'isMacho': isMacho,
      'categoria': categoria.toMap(),
    };
  }

  factory Reprodutor.fromMap(Map<String, dynamic> map) {
    return Reprodutor(
      img: map['img'],
      nome: map['nome'],
      isMacho: map['isMacho'],
      categoria: CategoriaAnimal.fromMap(map['categoria']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reprodutor.fromJson(String source) =>
      Reprodutor.fromMap(json.decode(source));

  @override
  String text() {
    return this.nome;
  }
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

  factory CategoriaAnimal.fromJson(String source) =>
      CategoriaAnimal.fromMap(json.decode(source));
}



//TODO: Implementar esse mocked

final mockedCategories = [
  {
    'categoria': 'Cachorro',
    'especies': [
      'Rotwailer',
      'Poodle',
      'Fila',
    ]
  },
  {
    'categoria': 'Gato',
    'especies': [
      'Persa',
      'Chaninha',
    ]
  },
];

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
