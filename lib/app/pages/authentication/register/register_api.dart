// FirebaseAuthenticationRepository
// IAuthentication
// register
import 'package:pedigree_seller/app/repositories/firestore_repository.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';
import 'package:pedigree_seller/app/models/user_model.dart';
import 'package:pedigree_seller/app/repositories/firebase_authentication_repository.dart';

class RegisterApi {
  static FirestoreRepository _repository = FirestoreRepository();
  static IAuthentication _auth = FirebaseAuthenticationRepository();

  static register(String email, String senha, UserModel user) async {
    var id = await _auth.register(email, senha);
    var u = user.copyWith(id: id);
    var map = user.copyWith(id: id).toMap();
    try {
      await _repository.put('sellers', map);
      return u..save();
    } catch (e, ex) {
      print(e);
      throw ex;
    }
    //TODO: Acho que essa porra pode ser nula de alguma forma
  }
}
