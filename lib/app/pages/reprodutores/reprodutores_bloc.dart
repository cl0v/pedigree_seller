import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class ReprodutoresBloc extends SimpleBloc<bool> {
  Future<bool> register(nome, categoria, isMacho) async {
    add(true);

    var response = await ReprodutoresFirestore.register(
      nome,
      categoria,
      isMacho,
    );

    add(false);

    return response;
  }

  //TODO: Refatorar

}
