import 'package:pedigree_seller/app/repositories/firestore_repository.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';
import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/repositories/firebase_authentication_repository.dart';

class RegisterApi {
  static FirestoreRepository _repository = FirestoreRepository();
  static IAuthentication _auth = FirebaseAuthenticationRepository();

  static Future<bool> register(
    String email,
    String senha,
    String cpf,
    String nome,
    String contato,
  ) async {
    //TODO: Testar quando ja existe user com esse email
    //TODO: Criar um ApiResponse
    try {
      UserModel user =
          UserModel(cpf: cpf, nome: nome, email: email, contato: contato);

      var id = await _auth.register(email, senha);
      var u = user.copyWith(id: id);
      var map = user.copyWith(id: id).toMap();
      await _repository.put('sellers', map);
      u.save();
      return true;
    } catch (e) {
      return false;
    }
  }
}
