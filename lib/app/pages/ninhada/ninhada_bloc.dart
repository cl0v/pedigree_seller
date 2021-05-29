import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class NinhadaBloc {
  final list = SimpleBloc<List<NinhadaModel>>();

  subscribe() async {
    try {
      await CanilModel.get().then((canil) {
        if (canil != null) {
          list.subscribe(NinhadaFirestore.stream(canil.referenceId));
        } else
          print('Canil nao registrado, algo deu errado!');
      });
    } catch (e) {
      print('Ocorreu um error');
    }
  }

  /* Create */
  final paiList = SimpleBloc<List<PaiMaeItem>>();
  final maeList = SimpleBloc<List<PaiMaeItem>>();

  fetchReprodutores(CategoriaAnimal categoria) async {
    var canil = await CanilModel.get();
    if (canil != null) {
      paiList.subscribe(NinhadaFirestore.fetchReprodutores(
        categoria,
        true,
        canilReferenceId: canil.referenceId,
      ));
      maeList.subscribe(NinhadaFirestore.fetchReprodutores(
        categoria,
        false,
        canilReferenceId: canil.referenceId,
      ));
    } else
      print('Como ainda n tem canil porra');
  }

  final createBtn = SimpleBloc<bool>();
  //TODO: Implement createBrn bloc
  Future<bool> create(
      String titulo, String fotoUrl, categoria, String pai, String mae) async {
    createBtn.add(true);
    var canil = await CanilModel.get();
    if (canil != null) {
      NinhadaModel ninhada = NinhadaModel(
        titulo: titulo,
        categoria: categoria,
        paiId: pai,
        maeId: mae,
        canilReferenceId: canil.referenceId,
      );
      var response = await NinhadaFirestore.register(ninhada);
      createBtn.add(false);
      return response;
    }
    return false;
  }
}
