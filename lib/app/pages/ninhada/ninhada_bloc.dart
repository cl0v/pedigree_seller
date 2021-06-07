import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/store_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/product_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/product_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class NinhadaBloc {

  NinhadaBloc(
    this.canil,
  );

  final Store canil;

  ProductFirestore get _repository => ProductFirestore(canil.id);

  get stream => _repository.readAll;

  final createBtnBloc = SimpleBloc<bool>();
  Future<bool> create(
    Foto foto,
    Product product,
  ) async {
    try {
      createBtnBloc.add(true);

      final response = await _repository.create(
        foto,
        product..storeId = canil.id,
      );
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
