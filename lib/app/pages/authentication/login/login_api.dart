import 'package:pedigree_seller/app/repositories/firestore_repository.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';
import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/repositories/firebase_authentication_repository.dart';

class LoginApi {
  static FirestoreRepository _repository = FirestoreRepository();
  static IAuthentication _auth = FirebaseAuthenticationRepository();

  static login(String email, String senha) async {
    var id = await _auth.login(email, senha);

    try {
      var map = await _repository.get('sellers', id);
      return User.fromMap(map)..save();
    } catch (e, ex) {
      print(e);
      throw ex;
    }
    //TODO: Acho que essa porra pode ser nula de alguma forma
  }
}
