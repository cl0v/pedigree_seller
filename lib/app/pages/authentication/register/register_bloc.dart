import 'package:pedigree_seller/app/pages/authentication/register/register_api.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class RegisterBloc extends SimpleBloc<bool> {
  Future<bool> register(
    String email,
    String senha,
    String cpf,
    String nome,
    String contato,
  ) async {
    add(true);

    var response = await RegisterApi.register(email, senha, cpf, nome, contato);

    add(false);

    return response;
  }
}
