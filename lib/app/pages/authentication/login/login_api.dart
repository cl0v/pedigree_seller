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
      if (map != null)
        return UserModel.fromMap(map)..save();
      else
        print('Salvei o codigo mano');
      //TODO: Ta rolando bug quando nao tem user salvo nas prefs(PRimeira vez que vai rodar o app quando troca de conta)
    } catch (e, ex) {
      print(e);
      throw ex;
    }
    //TODO: Acho que essa porra pode ser nula de alguma forma
  }
}
