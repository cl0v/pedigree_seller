import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedigree_seller/app/interfaces/authentication_interface.dart';

class FirebaseAuthenticationRepository implements IAuthentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Future login(String email, String senha) async {
    auth.signInWithEmailAndPassword(email: email, password: senha);
  }

  @override
  Future logout() async {
    auth.signOut();
  }

  @override
  Future register(String email, String senha) async {
    auth.createUserWithEmailAndPassword(email: email, password: senha);
  }
}
