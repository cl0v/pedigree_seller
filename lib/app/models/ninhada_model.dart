import 'package:pedigree_seller/app/models/pet_model.dart';

class Filhote {
  bool isMacho;
  String cor;
  //Sera que vale botar o preço do filhote individual?
  Filhote({
    required this.isMacho,
    required this.cor,
  });
  //Se eu precisar de foto do filhote eu venho aq
}

class NinhadaModel {
  String titulo;

  ///Pretendo colocar relação de cores com quantidade
  ///'Cores' (String) : quantidade (int)
  List<Filhote> filhotes;
  String fotoUrl; //TODO: Trocar para lista de foto
  String dataNascimento;
  String categoria;
  String especie;
  AnimalModel pai;
  AnimalModel mae;
  NinhadaModel({
    required this.titulo,
    required this.filhotes,
    required this.fotoUrl,
    required this.dataNascimento,
    required this.categoria,
    required this.especie,
    required this.pai,
    required this.mae,
  });
}

class FirebaseNinhadaModel extends NinhadaModel {
//TODO: DocumentReference reference
  int reference;
  FirebaseAnimalModel firebasePai;
  FirebaseAnimalModel firebaseMae;
  //TODO: Trocar para a data de nascimento do firebase: dataNascimento (Ou converter para a ninhadamodel mesmo)

  FirebaseNinhadaModel({
    required titulo,
    required filhotes,
    required categoria,
    required fotoUrl,
    required dataNascimento,
    required especie,
    required this.firebasePai,
    required this.firebaseMae,
    required this.reference,
  }) : super(
          titulo: titulo,
          filhotes: filhotes,
          fotoUrl: fotoUrl,
          categoria: categoria,
          dataNascimento: dataNascimento,
          especie: especie,
          pai: firebasePai,
          mae: firebaseMae,
        );
}

List<NinhadaModel> ninhadaListMock = [
  NinhadaModel(
    titulo: 'Primeira cria',
    filhotes: [],
    fotoUrl: 'fotoUrl',
    dataNascimento: 'dataNascimento',
    categoria: 'categoria',
    especie: 'especie',
    pai: petListMocked[0],
    mae: petListMocked[1],
  ),
  NinhadaModel(
    titulo: 'Primeira cria',
    filhotes: [],
    fotoUrl: 'fotoUrl',
    dataNascimento: 'dataNascimento',
    categoria: 'categoria',
    especie: 'especie',
    pai: petListMocked[0],
    mae: petListMocked[1],
  ),
];
