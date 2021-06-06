import 'dart:convert';


//TODO: Colocar indicador avisando o status do anuncio
//Aprovado, Negado, Aguardando
//Posso criar um modelo para trabalhar com essas infos

class NinhadaModel {
  ///Pretendo colocar relação de cores com quantidade
//TODO: Substituir tudo por static para ter acesso facilitado e menos erros
// static final String  pImg = 'img';
// static final String  pTitle = 'titulo';
// static final String  pCategory = 'categoria';
// static final String  pStoreReference = 'canilReferenceId';
  ///'Cores' (String) : quantidade (int)
  //Cores disponiveis
  //Preco de cada filhote
  String img;
  String titulo;
  CategoriaAnimal categoria;
  // String paiId; //TODO: Substituir para referencia
  // String maeId; //TODO: Substituir para referencia
  String? canilReferenceId; //TODO: Substituir por referencia
  // String? reference; //TODO: Substituir por referencia
 
  NinhadaModel({
    this.img = '',
    required this.titulo,
    required this.categoria,
    // required this.paiId,
    // required this.maeId,
    this.canilReferenceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'titulo': titulo,
      'categoria': categoria.toMap(),
      'canilReferenceId': canilReferenceId,
    };
  }

  factory NinhadaModel.fromMap(Map<String, dynamic> map) {
    return NinhadaModel(
      img: map['img'] ?? '',
      titulo: map['titulo'],
      categoria: CategoriaAnimal.fromMap(map['categoria']),
      canilReferenceId: map['canilReferenceId'],
    );
  }

  // factory NinhadaModel.fromDocumentSnapshot()

  String toJson() => json.encode(toMap());

  factory NinhadaModel.fromJson(String source) =>
      NinhadaModel.fromMap(json.decode(source));


  NinhadaModel copyWith({
    String? img,
    String? titulo,
    CategoriaAnimal? categoria,
    String? canilReferenceId,
  }) {
    return NinhadaModel(
      img: img ?? this.img,
      titulo: titulo ?? this.titulo,
      categoria: categoria ?? this.categoria,
      canilReferenceId: canilReferenceId ?? this.canilReferenceId,
    );
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

