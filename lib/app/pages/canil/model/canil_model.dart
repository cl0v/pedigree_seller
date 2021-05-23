class CanilModel {
  //Lista de ninhadas
  String titulo;
  String contato;
  String cnpj;
  String dataCadastro;
  String donoID; //Trocar mais tarde por referencia
  List<String> ninhadasReferencia;
  List<String> reprodutoresReferencia;
  CanilModel({
    required this.titulo,
    required this.contato,
    required this.cnpj,
    this.dataCadastro = '',
    this.donoID = '',
    this.ninhadasReferencia  = const [],
    this.reprodutoresReferencia  = const [],
  });

}

final CanilModel canilMocked = CanilModel(
  titulo: 'titulo',
  contato: 'contato',
  cnpj: 'cnpj',
  dataCadastro: 'dataCadastro',
  donoID: 'donoID',
  ninhadasReferencia: ['ninhadasReferencia'],
  reprodutoresReferencia: ['reprodutoresReferencia'],
);
