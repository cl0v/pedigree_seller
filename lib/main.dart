import 'package:flutter/material.dart';
import 'package:pedigree_seller/pedigree.dart';
import 'package:firebase_core/firebase_core.dart';

//TODO: ADICIONAR REFERENCE EM TODOS E REFAZER A _FIRESTORE PORRA


/*//TODO: O que fazer antes de ir para o servidor ou outro app
->> Materiais de estudo flutter/gallery no github
- Corrigir ImagePicker
- ImagePicker vai comunicar com o Controller
- Adicionar a pagina do pet para vizualizar como ficará na página do aplicativo
- Pagina da lista de ninhada (botao (...) será criado como um menuButton)
*/

//TODO: Criar cadastro do canil
//TODO: Terminar o cadastro do usuário

//TODO: Use modelos e variaveis em ptBr, vai evitar perder tempo pensando em ing

//TODO: Fazer a splash screen do pedigree (logo) ser uma hero com a loginscreen

//TODO: Posso verificar cnpj e cpf por aqui(alguma api)
//ou posso fazer pelo cloud funcitons
//Por aqui existem riscos 
//TODO: Aguardar aprovação do canil (Fazer isso automaticamente mais tarde)
// (Provavelmente com cloud functions)

//Sellers pode ser uma extencao de users, porem com alguns provilegios

//Somente um pet
Map<String, dynamic> petQueApareceNoAppDoUser = {
  "titulo": "Cachorrinhos fofos",
  "preco": "3000,00",
  "phone": "99999999999",
  "data": "22/05/2021",
  "categoria": {
    "categoria": "Cachorro",
    "especie": "Rotwailer",
  },
  "pais": {
    "pai": "ReferenciaXXXXX",
    "mae": "ReferenciaXXXXX",
  },
  "canil": "ReferenciaXXXXX",
  "cores": {
    "preto": {
      "quantidade": 3,
      "isMacho": 2,
    },
    "branco": {
      "quantidade": 6,
      "isMacho": 4,
    },
    "misto": {
      "quantidade": 1,
      "isMacho": 0,
    },
  },
};

Map<String, dynamic> canil = {
  'titulo': 'Canil do Ze',
  'dataCadastro': '',
};

Map<String, dynamic> vendedor = {
  'nome': 'Marcelo',
  'cpf': '09847031060',
  'contato': '337998515299',
  'ninhadas': ['Referencia1', 'Referencia2', 'Referencia3'],
  'canil': 'Referenciaxxx',
  'historico': {}, //Nao sei o que colocar aqui
  //TODO: Futuramente pedir cadastro de cnpj etc(Depois de entregar o basico do app, pois nao sei como fazer e n vou aprender)
};



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Pedigree());
}
