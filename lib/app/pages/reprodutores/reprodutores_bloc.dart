import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class ReprodutoresBloc {
  final registerBtnBloc = SimpleBloc<bool>();

  final CanilModel canil;

  ReprodutoresFirestore get _repository =>
      ReprodutoresFirestore(canil.referenceId);

  ReprodutoresBloc(this.canil);

  Stream<List<Reprodutor>> get stream => _repository.stream;

  //TODO: Remover pedigree por enquanto
  Future<bool> register(
    Foto foto,
    Reprodutor reprodutor,
  ) async {
    try {
      registerBtnBloc.add(true);
      var response = await _repository.register(
        foto: foto,
        reprodutor: reprodutor,
      );

      registerBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
