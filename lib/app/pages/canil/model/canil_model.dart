class CanilModel {
  //Lista de ninhadas
  String titulo;
  String contato;
  String cnpj;
  String dataCadastro;
  String donoReferencia;
  List<String> ninhadasReferencia;
  List<String> reprodutoresReferencia;
  CanilModel({
    required this.titulo,
    required this.contato,
    required this.cnpj,
    this.dataCadastro = '',
    this.donoReferencia = '',
    this.ninhadasReferencia  = const [],
    this.reprodutoresReferencia  = const [],
  });

  @override
  String toString() {
    return 'CanilModel(titulo: $titulo, contato: $contato, cnpj: $cnpj, dataCadastro: $dataCadastro, donoReferencia: $donoReferencia, ninhadasReferencia: $ninhadasReferencia, reprodutoresReferencia: $reprodutoresReferencia)';
  }
}

final CanilModel canilMocked = CanilModel(
  titulo: 'titulo',
  contato: 'contato',
  cnpj: 'cnpj',
  dataCadastro: 'dataCadastro',
  donoReferencia: 'donoReferencia',
  ninhadasReferencia: ['ninhadasReferencia'],
  reprodutoresReferencia: ['reprodutoresReferencia'],
);
