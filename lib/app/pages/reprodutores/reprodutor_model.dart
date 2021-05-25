import 'dart:convert';
//TODO: Deverá extender um DropDownMenuItem(aula 255* de dropdown button)
//Lembrando q o unico objetivo desse cara é ser um facilitador para cadastrar a ninhada 
class ReprodutorModel {
  String file;
  String certificado;
  String nome;
  bool isMacho;
  EspecificacoesAnimalModel categoria;

  ReprodutorModel({
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

  factory ReprodutorModel.fromMap(Map<String, dynamic> map) {
    return ReprodutorModel(
      file: map['file'],
      certificado: map['certificado'],
      nome: map['nome'],
      isMacho: map['isMacho'],
      categoria: EspecificacoesAnimalModel.fromMap(map['categoria']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReprodutorModel.fromJson(String source) => ReprodutorModel.fromMap(json.decode(source));

}

class EspecificacoesAnimalModel {
  String categoria;
  String especie;
  EspecificacoesAnimalModel({
    required this.categoria,
    required this.especie,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'especie': especie,
    };
  }

  factory EspecificacoesAnimalModel.fromMap(Map<String, dynamic> map) {
    return EspecificacoesAnimalModel(
      categoria: map['categoria'],
      especie: map['especie'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EspecificacoesAnimalModel.fromJson(String source) => EspecificacoesAnimalModel.fromMap(json.decode(source));
}
//TODO: Remover esses mocks

final m1 = ReprodutorModel(
  nome: 'Vagabunda',
  categoria:
      EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: false,
);

final m2 = ReprodutorModel(
  nome: 'Lora',
  categoria:
      EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: false,
);

final p1 = ReprodutorModel(
  nome: 'Vagabund',
  categoria:
      EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: true,
);

final p2 = ReprodutorModel(
  nome: 'Popo',
  categoria:
      EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: true,
);
