
//TODO: Foi o que criei agora porra
import 'package:pedigree_seller/app/models/raca_model.dart';
import 'package:pedigree_seller/app/pages/pets/pet_registration/pet_registration_screen.dart';

class ReprodutoresModel {
  String file = 'FileUrl';
  String certificado = 'FileUrl';
  String nome;
  Raca categoria;
  bool isMacho;

  ReprodutoresModel({
    // required this.file,
    // required this.certificado,
    required this.nome,
    required this.categoria,
    required this.isMacho,
  });

  @override
  String toString() {
    return 'ReprodutoresModel(file: $file, certificado: $certificado, nome: $nome, categoria: ${categoria.toString()}, isMacho: $isMacho)';
  }
}