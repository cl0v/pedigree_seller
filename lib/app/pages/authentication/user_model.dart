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
  String? id;

  UserModel({
    required this.cpf,
    required this.nome,
    required this.email,
    required this.contato,
    this.id,
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    cpf = json['cpf'];
    nome = json['nome'];
    email = json['email'];
    contato = json['contato'];
    id = json['id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['contato'] = this.contato;
    data['id'] = this.id;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      UserModel.fromMap(
        snapshot.data()!,
      ).copyWith(
        id: snapshot.reference.id,
      );

  static Future<UserModel?> get() async {
    final json = await Prefs.get('seller.prefs');
    if (json != null)
      return json.isEmpty ? null : UserModel.fromJson(json);
    else
      return null;
  }

  save() {
    String json = toJson();
    Prefs.put('seller.prefs', json);
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
  }) {
    return UserModel(
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      contato: contato ?? this.contato,
      id: id ?? this.id,
    );
  }
}
