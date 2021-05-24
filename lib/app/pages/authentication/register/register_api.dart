import 'package:pedigree_seller/app/repositories/firestore_repository.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
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
      var id = await _auth.register(email, senha);
      UserModel user = UserModel(
          cpf: cpf, nome: nome, email: email, contato: contato, id: id);

      await _repository.put('sellers', user.toMap());
      user.save();
      return true;
    } catch (e) {
      return false;
    }
  }
}
