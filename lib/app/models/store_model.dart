class StoreModel {
  //Lista de ninhadas
  String titulo;
  String contato;
  String cnpj;
  String dataCadastro;
  String donoReferencia;
  List<String> ninhadasReferencia;
  List<String> reprodutoresReferencia;
  StoreModel({
    required this.titulo,
    required this.contato,
    required this.cnpj,
    required this.dataCadastro,
    required this.donoReferencia,
    required this.ninhadasReferencia,
    required this.reprodutoresReferencia,
  });
}
