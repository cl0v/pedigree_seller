import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String nome;
  String email;
  UserModel({
    required this.id,
    required this.nome,
    required this.email,
  });
  //Reprodutores será uma collection
  // Ninhada será uma lista

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
    };
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
        //TODO: Corrigir isso
    return UserModel(
      id: snapshot.reference.id,
      nome: snapshot.data()!['nome'],
      email: snapshot.data()!['email'],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
