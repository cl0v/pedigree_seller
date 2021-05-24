import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

//MEU USUARIO NAO PRECISA DA REFERENCIA DO CANIL, BASTA EU USAR MEU UID PARA PESQUISAR NOS CANILS
//JUNTAR USUARIOS COM SELLERS
class UserModel {
  late final String cpf;
  late final String nome;
  late final String email;
  late final String contato;
  late final String id;
  String referenceId;

  UserModel({
    required this.cpf,
    required this.nome,
    required this.email,
    required this.contato,
    required this.id,
    this.referenceId = '',
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        cpf: json['cpf'],
        nome: json['nome'],
        email: json['email'],
        contato: json['contato'],
        id: json['id'],
      );

  Map<String, dynamic> toMap() => {
        'cpf': cpf,
        'nome': nome,
        'email': email,
        'contato': contato,
        'id': id,
      };

  String toJson() => json.encode(toMap());


  Map<String, dynamic> toMapWithReference() => {
        'cpf': cpf,
        'nome': nome,
        'email': email,
        'contato': contato,
        'id': id,
        'referenceId': referenceId
      };

      factory UserModel.fromMapWithReference(Map<String, dynamic> json) => UserModel(
        cpf: json['cpf'],
        nome: json['nome'],
        email: json['email'],
        contato: json['contato'],
        id: json['id'],
        referenceId: json['referenceId'],
      );


  factory UserModel.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      UserModel.fromMap(snapshot.data()!)
          .copyWith(referenceId: snapshot.reference.id);


  factory UserModel.fromJson(String source) =>
      UserModel.fromMapWithReference(json.decode(source));

  static Future<UserModel?> get() async {
    final json = await Prefs.get('seller.prefs');
    if (json != null)
      return json.isEmpty ? null : UserModel.fromJson(json);
    else
      return null;
  }

  save() {
    String json = jsonEncode(toMapWithReference());
    Prefs.put('seller.prefs', json);
    print('USER SAVED: > $json');
  }

  static clear() {
    Prefs.put('seller.prefs', '');
  }

  UserModel copyWith({
    String? cpf,
    String? nome,
    String? email,
    String? contato,
    String? id,
    String? referenceId,
  }) {
    return UserModel(
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      contato: contato ?? this.contato,
      id: id ?? this.id,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
