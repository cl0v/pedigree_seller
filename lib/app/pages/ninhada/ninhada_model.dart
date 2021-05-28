import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import '../../components/drop_down_button_widget.dart';

//TODO: Colocar indicador avisando o status do anuncio
//Aprovado, Negado, Aguardando
//Posso criar um modelo para trabalhar com essas infos

class NinhadaModel {
  ///Pretendo colocar relação de cores com quantidade
  ///'Cores' (String) : quantidade (int)
  //Cores disponiveis
  //Preco de cada filhote
  String titulo;
  CategoriaAnimal categoria;
  String paiId;
  String maeId;
  String canilReferenceId;
  String? reference;

  NinhadaModel({
    required this.titulo,
    required this.categoria,
    required this.paiId,
    required this.maeId,
    required this.canilReferenceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'categoria': categoria.toMap(),
      'paiId': paiId,
      'maeId': maeId,
      'canilReferenceId': canilReferenceId,
    };
  }

  factory NinhadaModel.fromMap(Map<String, dynamic> map) {
    return NinhadaModel(
      titulo: map['titulo'],
      categoria: CategoriaAnimal.fromMap(map['categoria']),
      paiId: map['paiId'],
      maeId: map['maeId'],
      canilReferenceId: map['canilReferenceId'],
    );
  }

  // factory NinhadaModel.fromDocumentSnapshot()

  String toJson() => json.encode(toMap());

  factory NinhadaModel.fromJson(String source) =>
      NinhadaModel.fromMap(json.decode(source));
}

class PaiMaeItem extends DropDownItem {
  String nome;
  CategoriaAnimal? specs;
  String? referenceId;
  PaiMaeItem({
    required this.nome,
    this.specs,
    this.referenceId,
  });

  @override
  String text() {
    return nome;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaiMaeItem &&
        other.nome == nome &&
        other.referenceId == referenceId;
  }

  @override
  int get hashCode => nome.hashCode ^ referenceId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'specs': specs?.toMap(),
      'referenceId': referenceId,
    };
  }

  factory PaiMaeItem.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot);
    return PaiMaeItem.fromMap(snapshot.data())
        .copyWith(referenceId: snapshot.reference.id);
  }

  factory PaiMaeItem.fromMap(Map<String, dynamic> map) {
    return PaiMaeItem(
      nome: map['nome'],
      specs: CategoriaAnimal.fromMap(map['specs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaiMaeItem.fromJson(String source) =>
      PaiMaeItem.fromMap(json.decode(source));

  PaiMaeItem copyWith({
    String? nome,
    CategoriaAnimal? specs,
    String? referenceId,
  }) {
    return PaiMaeItem(
      nome: nome ?? this.nome,
      specs: specs ?? this.specs,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
