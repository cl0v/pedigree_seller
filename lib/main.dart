import 'package:flutter/material.dart';
import 'package:pedigree_seller/pedigree.dart';
import 'package:firebase_core/firebase_core.dart';

// >>>>> Eu estava fazendo o [canilmodel.get()] functionar na canil_bloc
//Estou testando com o email marcelo.itaa.boss@gmail.com um novo canil
//TODO: Ta rolando um bug quando eu saio do app


/** //TODO:
 * Ordene as páginas
 * Adicione fotos na ninhada
 * Altere o nome das coisas
 * Quando toca no botao, envia para o whatsapp
 */

/** //BUG:
 * Não está sendo carregado o usuário
 */



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Pedigree());
}
//TODO: Adicionar imagem do filhote

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
