import 'dart:convert';

import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';

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
  ///Pretendo colocar relação de cores com quantidade
  ///'Cores' (String) : quantidade (int)
  String titulo;
  EspecificacoesAnimalModel categoria;
  ReprodutorModel pai;
  ReprodutorModel mae;
  String canilReferenceId;

  NinhadaModel({
    required this.titulo,
    required this.categoria,
    required this.pai,
    required this.mae,
    required this.canilReferenceId,
  });
 

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'categoria': categoria.toMap(),
      'pai': pai.toMap(),
      'mae': mae.toMap(),
      'canilReferenceId': canilReferenceId,
    };
  }

  factory NinhadaModel.fromMap(Map<String, dynamic> map) {
    return NinhadaModel(
      titulo: map['titulo'],
      categoria: EspecificacoesAnimalModel.fromMap(map['categoria']),
      pai: ReprodutorModel.fromMap(map['pai']),
      mae: ReprodutorModel.fromMap(map['mae']),
      canilReferenceId: map['canilReferenceId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NinhadaModel.fromJson(String source) => NinhadaModel.fromMap(json.decode(source));
}
List<ReprodutorModel> petListMocked = [
  ReprodutorModel(
    nome: 'Leão',
    isMacho: true,
    categoria:
        EspecificacoesAnimalModel(categoria: 'Dog', especie: 'Rotwailler'),
    file:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Labrador_on_Quantock_%282175262184%29.jpg/1200px-Labrador_on_Quantock_%282175262184%29.jpg',
    certificado: 'https://www.sobraci.com.br/uploads/577d3f2.jpg',
  ),
  ReprodutorModel(
    nome: 'Lora',
    isMacho: false,
    categoria:
        EspecificacoesAnimalModel(categoria: 'Dog', especie: 'Rotwailler'),
    file:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Labrador_on_Quantock_%282175262184%29.jpg/1200px-Labrador_on_Quantock_%282175262184%29.jpg',
    certificado: 'https://www.sobraci.com.br/uploads/577d3f2.jpg',
  ),
];
