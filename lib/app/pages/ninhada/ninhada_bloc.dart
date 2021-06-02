import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class NinhadaBloc {
  final CanilModel canil;

  NinhadaBloc(this.canil);

  NinhadaFirestore get _repository => NinhadaFirestore(canil.referenceId);

  get stream => _repository.stream;


  final createBtnBloc = SimpleBloc<bool>();
  Future<bool> create( Foto foto,NinhadaModel ninhada) async {
    try {
      createBtnBloc.add(true);
      ninhada = ninhada.copyWith(canilReferenceId: canil.referenceId);

      var response = await _repository.register(foto, ninhada);
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
