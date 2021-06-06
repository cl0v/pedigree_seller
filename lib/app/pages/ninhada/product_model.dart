import 'dart:convert';

//TODO: Colocar indicador avisando o status do anuncio
//Aprovado, Negado, Aguardando
//Posso criar um modelo para trabalhar com essas infos

class Product {
  ///Pretendo colocar relação de cores com quantidade
//TODO: Substituir tudo por static para ter acesso facilitado e menos erros
  static final String pImgUrl = 'imgUrl';
  static final String pTitle = 'title';
  static final String pCategory = 'category';
  static final String pApproved = 'approved';
  static final String pStoreId = 'storeId';

  String? id; //TODO: Implementar o id(Nao existia antes)
  String imgUrl;
  String title;
  CategoriaFilhote category;
  bool approved;
  String storeId;
  String? preco; //TODO: implement price

  Product({
    this.imgUrl = '',
    required this.title,
    required this.category,
    required this.storeId,
    this.approved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      pImgUrl: imgUrl,
      pTitle: title,
      pCategory: category.toMap(),
      pStoreId: storeId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imgUrl: map[pImgUrl] ?? '',
      title: map[pTitle],
      category: CategoriaFilhote.fromMap(map[pCategory]),
      storeId: map[pStoreId],
    );
  }


  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Product copyWith({
    String? img,
    String? titulo,
    CategoriaFilhote? categoria,
    String? canilReferenceId,
  }) {
    return Product(
      imgUrl: img ?? this.imgUrl,
      title: titulo ?? this.title,
      category: categoria ?? this.category,
      storeId: canilReferenceId ?? this.storeId,
    );
  }
}

class CategoriaFilhote {
  static final String pCategory = 'category';
  static final String pBreed = 'breed';

  CategoriaFilhote({
    required this.category,
    required this.breed,
  });

  String category;
  String breed;

  CategoriaFilhote.fromMap(Map<String, dynamic> map)
      : this(
          category: map[pCategory],
          breed: map[pBreed],
        );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[pCategory] = this.category;
    data[pBreed] = this.breed;
    return data;
  }
}
