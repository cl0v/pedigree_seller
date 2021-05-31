import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';
import 'package:rxdart/subjects.dart';

class ReprodutoresBloc {
  final bloc = SimpleBloc<List<Reprodutor>>();
  final registerBtnBloc = SimpleBloc<bool>();

  

  final CanilModel canil;

  ReprodutoresBloc(this.canil);

  sub() async {
    try {
      bloc.subscribe(ReprodutoresFirestore.stream(canil.referenceId));
    } catch (e) {
      print(e);
    }
  }

  //TODO: Remover pedigree por enquanto
  Future<bool> register(
    Foto foto,
    Reprodutor reprodutor,
    Foto? fotoPedigree,
  ) async {
    try {
      registerBtnBloc.add(true);
      var response = await ReprodutoresFirestore.register(
        foto: foto,
        reprodutor: reprodutor,
        fotoCertificado: fotoPedigree,
        canilReferenceId: canil.referenceId,
      );

      registerBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
