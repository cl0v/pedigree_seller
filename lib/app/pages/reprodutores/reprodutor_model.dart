import 'dart:convert';
//TODO: Deverá ser um DropDownMenuItem aula 225
class ReprodutorModel {
  String file;
  String certificado;
  String nome;
  bool isMacho;
  String? donoId; //TAlvez nao seja bom expor esse id nos dados 'publicos'
  EspecificacoesAnimalModel categoria;

  ReprodutorModel({
    this.file = 'FileUrl',
    this.certificado = 'FileUrl',
    required this.nome,
    required this.categoria,
    required this.isMacho,
    this.donoId,
  });

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'certificado': certificado,
      'nome': nome,
      'isMacho': isMacho,
      'donoId': donoId,
      'categoria': categoria.toMap(),
    };
  }

  factory ReprodutorModel.fromMap(Map<String, dynamic> map) {
    return ReprodutorModel(
      file: map['file'],
      certificado: map['certificado'],
      nome: map['nome'],
      isMacho: map['isMacho'],
      donoId: map['donoId'],
      categoria: EspecificacoesAnimalModel.fromMap(map['categoria']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReprodutorModel.fromJson(String source) => ReprodutorModel.fromMap(json.decode(source));

  ReprodutorModel copyWith({
    String? file,
    String? certificado,
    String? nome,
    bool? isMacho,
    String? donoId,
    EspecificacoesAnimalModel? categoria,
  }) {
    return ReprodutorModel(
      file: file ?? this.file,
      certificado: certificado ?? this.certificado,
      nome: nome ?? this.nome,
      isMacho: isMacho ?? this.isMacho,
      donoId: donoId ?? this.donoId,
      categoria: categoria ?? this.categoria,
    );
  }
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

Map<String, List<String>> racas = {
  'Cachorro': [
    'Rotwailer',
    'Poodle',
    'Fila',
  ],
  'Gato': [
    'Persa',
    'Chaninha',
  ],
  'Hamster': [],
  'Coelho': [],
};

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
