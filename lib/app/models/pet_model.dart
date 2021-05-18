//TODO: Salvar em

class AnimalModel {
  String name;
  bool isMacho;
  String fotoUrl;
  String categoria;
  String especie;
  String certificadoPedigree;
  //TODO: Criar extensao para pedigree (DogModel ou melhor bixos que pessam pedigree ou mamiferos)
  AnimalModel({
    required this.name,
    required this.isMacho,
    required this.categoria,
    required this.especie,
    required this.fotoUrl,
    required this.certificadoPedigree,
  });
}

class FirebaseAnimalModel extends AnimalModel {
  String referenceId;
  FirebaseAnimalModel({
    required name,
    required isMacho,
    required categoria,
    required especie,
    required fotoUrl,
    required certificadoPedigree,
    required this.referenceId,
  }) : super(
          name: name,
          isMacho: isMacho,
          categoria: categoria,
          especie: especie,
          fotoUrl: fotoUrl,
          certificadoPedigree: certificadoPedigree,
        );
}

List<String> petCategories = [
  'Gato',
  'Cachorro',
  'Coelho',
  'Hamster',
];

List<String> petSpecies = [
  'Rotwailer',
  'Cachorro',
  'Coelho',
  'Hamster',
];

List<AnimalModel> petListMocked = [
  AnimalModel(
    name: 'Leão',
    isMacho: true,
    categoria: 'Dog',
    especie: 'Labrador',
    fotoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Labrador_on_Quantock_%282175262184%29.jpg/1200px-Labrador_on_Quantock_%282175262184%29.jpg',
    certificadoPedigree: 'https://www.sobraci.com.br/uploads/577d3f2.jpg',
  ),
  AnimalModel(
    name: 'Lora',
    isMacho: false,
    categoria: 'Dog',
    especie: 'Labrador',
    fotoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Labrador_on_Quantock_%282175262184%29.jpg/1200px-Labrador_on_Quantock_%282175262184%29.jpg',
    certificadoPedigree: 'https://www.sobraci.com.br/uploads/577d3f2.jpg',
  ),
];
