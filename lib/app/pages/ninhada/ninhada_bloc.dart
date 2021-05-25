import 'package:pedigree_seller/app/pages/canil/canil_model.dart';
import 'package:pedigree_seller/app/pages/ninhada/cadastrar_ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_firestore.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_model.dart';
import 'package:pedigree_seller/app/pages/reprodutores/reprodutor_model.dart';
import 'package:pedigree_seller/app/utils/simple_bloc.dart';

class NinhadaBloc {
  final createBtn = SimpleBloc<bool>();

  final paiList = SimpleBloc<List<PaiMaeItem>>();
  final maeList = SimpleBloc<List<PaiMaeItem>>();

  fetchPai(
    // EspecificacoesAnimalModel? specs,
    bool isMacho,
  ) async {
    var canil = await CanilModel.get();
    if (canil != null)
      paiList.subscribe(NinhadaFirestore.fetchPais(isMacho,
          canilReferenceId: canil.referenceId));
    else
      print('Como ainda n tem canil porra');
  }

  final list = SimpleBloc<List<NinhadaModel>>();

  Future<bool> create(
    titulo,
    fotoUrl,
    dataNascimento,
    categoria,
    pai,
    mae,
  ) async {
    //TODO: Enviar um id errado para testar o tryCatch daqui;
    var canil = await CanilModel.get();
    if (canil != null) {
      NinhadaModel ninhada = NinhadaModel(
        titulo: titulo,
        categoria: categoria,
        pai: pai,
        mae: mae,
        canilReferenceId: canil.referenceId,
      );
      var response = await NinhadaFirestore.register(ninhada);
      return response;
    }
    print('Nenhum canil cadastrado, ta maluco?');
    return false;
  }
}
