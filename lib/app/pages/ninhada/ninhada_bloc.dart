import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class NinhadaBloc {

  final CanilModel canil;

  NinhadaBloc(this.canil);

  NinhadaFirestore get _repository => NinhadaFirestore(canil.referenceId);

  get stream => _repository.stream;

  /* Create */
  final paisBloc = SimpleBloc<List<Reprodutor>>();
  final maesBloc = SimpleBloc<List<Reprodutor>>();

  fetchReprodutores(CategoriaAnimal categoria) async {
    final _reprodutorFirestore = ReprodutoresFirestore(canil.referenceId);
    paisBloc.subscribe(
        _reprodutorFirestore.sortByCategoriaAndGender(categoria, true));
    maesBloc.subscribe(
        _reprodutorFirestore.sortByCategoriaAndGender(categoria, false));
    // paisBloc.subscribe(NinhadaFirestore.fetchReprodutores(
    //   categoria,
    //   true,
    //   canilReferenceId: canil.referenceId,
    // ));
    // maesBloc.subscribe(NinhadaFirestore.fetchReprodutores(
    //   categoria,
    //   false,
    //   canilReferenceId: canil.referenceId,
    // ));
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
      var response = await _repository.register(foto, ninhada);
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
