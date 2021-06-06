import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/authentication/firebase_authentication_repository.dart';
//TODO: Testar quando ja existe user com esse email
//TODO: Implementar tratamento de exception para erros especificos

class AuthenticationFirestore {
  static IAuthentication _auth = FirebaseAuthenticationRepository();

  static final String collectionPath = 'users';

  static Future<UserModel?> login(String email, String senha) async {
    try {
      var id = await _auth.login(email, senha);
      
    //TODO: Tratar os erros
    //There is no user record corresponding to this identifier. The user may have been deleted.    
      var query = await FirebaseFirestore.instance
          .collection(collectionPath)
          .where('id', isEqualTo: id)
          .get();

      var referencia = query.docs.first;
      if (referencia.exists) {
        var user = UserModel.fromDocumentSnapshot(referencia);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> register(
    String email,
    String senha,
    String cpf,
    String nome,
    String contato,
  ) async {
    try {
      var id = await _auth.register(email, senha);
      UserModel user = UserModel(
        cpf: cpf,
        nome: nome,
        email: email,
        contato: contato,
        id: id,
      );

      var referencia = await FirebaseFirestore.instance
          .collection(collectionPath)
          .add(user.toMap());

      user.copyWith(referenceId: referencia.id).save();
      return true;
    } catch (e) {
      return false;
    }
  }
}
