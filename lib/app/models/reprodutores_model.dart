
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
}

class EspecificacoesAnimalModel {
  String categoria;
  String especie;
  EspecificacoesAnimalModel({
    required this.categoria,
    required this.especie,
  });
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
  categoria: EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: false,
);

final m2 = ReprodutorModel(
  nome: 'Lora',
  categoria: EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: false,
);

final p1 = ReprodutorModel(
  nome: 'Vagabund',
  categoria: EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: true,
);

final p2 = ReprodutorModel(
  nome: 'Popo',
  categoria: EspecificacoesAnimalModel(categoria: 'Cachorro', especie: 'Hamster'),
  isMacho: true,
);
