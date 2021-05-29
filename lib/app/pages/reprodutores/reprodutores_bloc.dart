import 'package:pedigree_seller/app/components/image_picker_tile_widget.dart';
import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutores_firestore.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class ReprodutoresBloc {
  final reprodutores = SimpleBloc<List<Reprodutor>>();
  final registerBtn = SimpleBloc<bool>();

  sub() async {
    try {
      var canil = await CanilModel.get();
      if (canil != null)
        reprodutores.subscribe(ReprodutoresFirestore.stream(canil.referenceId));
      else {
        print('Canil nao registrado, algo deu errado!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> register(
      Foto foto, Reprodutor reprodutor, Foto fotoPedigree) async {
    try {
      registerBtn.add(true);
      var canil = await CanilModel.get();
      if (canil != null) {
        var response = await ReprodutoresFirestore.register(
          foto: foto,
          reprodutor: reprodutor,
          fotoCertificado: fotoPedigree,
          canilReferenceId: canil.referenceId,
        );

        registerBtn.add(false);
        return response;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
