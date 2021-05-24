import 'package:pedigree_seller/app/repositories/firestore_repository.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/repositories/firebase_authentication_repository.dart';

class LoginFirestore {
  static FirestoreRepository _repository = FirestoreRepository();
  static IAuthentication _auth = FirebaseAuthenticationRepository();

  
//TODO: Refatorar o login


  static Future<bool> login(String email, String senha) async {
    try {
      var id = await _auth.login(email, senha);
      var map = await _repository.get('sellers', id);
      if (map != null) {
        UserModel.fromMap(map)..save();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
