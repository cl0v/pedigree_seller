import 'package:pedigree_seller/app/pages/authentication/login/login_api.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<bool> login(String email, String senha) async {
    add(true);

    var response = await LoginApi.login(email, senha);

    add(false);

    return response;
  }
}
