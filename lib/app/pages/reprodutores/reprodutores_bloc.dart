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

  Future<bool> register(nome, categoria, isMacho, Foto file) async {
    try {
      registerBtn.add(true);
      var canil = await CanilModel.get();
      if (canil != null) {
        Reprodutor reprodutorModel = Reprodutor(
          nome: nome,
          categoria: categoria,
          isMacho: isMacho,
        );
        var response = await ReprodutoresFirestore.register(
          reprodutor: reprodutorModel,
          canilReferenceId: canil.referenceId,
          pedigreeFile: file,
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
