import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class NinhadaBloc {
  final bloc = SimpleBloc<List<NinhadaModel>>();

  final CanilModel canil;

  NinhadaBloc(this.canil);

  subscribe() async {
    try {
      bloc.subscribe(NinhadaFirestore.stream(canil.referenceId));
    } catch (e) {
      print('Ocorreu um error');
    }
  }

  /* Create */
  final paisBloc = SimpleBloc<List<PaiMaeItem>>();
  final maesBloc = SimpleBloc<List<PaiMaeItem>>();

  fetchReprodutores(CategoriaAnimal categoria) async {
    paisBloc.subscribe(NinhadaFirestore.fetchReprodutores(
      categoria,
      true,
      canilReferenceId: canil.referenceId,
    ));
    maesBloc.subscribe(NinhadaFirestore.fetchReprodutores(
      categoria,
      false,
      canilReferenceId: canil.referenceId,
    ));
  }

  final createBtnBloc = SimpleBloc<bool>();
  Future<bool> create(
      String titulo, Foto foto, categoria, String pai, String mae) async {
    try {
      createBtnBloc.add(true);
      NinhadaModel ninhada = NinhadaModel(
        titulo: titulo,
        categoria: categoria,
        paiId: pai,
        maeId: mae,
        canilReferenceId: canil.referenceId,
      );
      var response = await NinhadaFirestore.register(ninhada);
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
