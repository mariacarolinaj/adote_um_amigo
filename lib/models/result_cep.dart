class ResultCep {
  late String cep;
  late String logradouro;
  late String complemento;
  late String bairro;
  late String localidade;
  late String uf;
  late String unidade;
  late String ibge;
  late String gia;

  ResultCep.empty();

  ResultCep(
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.unidade,
    this.ibge,
    this.gia,
  );

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "unidade": unidade,
        "ibge": ibge,
        "gia": gia,
      };

  ResultCep.fromMap(Map<String, dynamic> map) {
    cep = map["id"];
    logradouro = map["nome"];
    complemento = map["email"];
    bairro = map["imagemPerfil"];
    localidade = map["imagemCapa"];
    uf = map["apresentacao"];
    unidade = map["password"];
    ibge = map["latGeo"];
    gia = map["lonGeo"];
  }

  factory ResultCep.fromJson(Map<String, dynamic> retorno) {
    return ResultCep(
      retorno['cep'] ?? '',
      retorno['logradouro'] ?? '',
      retorno['complemento'] ?? '',
      retorno['bairro'] ?? '',
      retorno['localidade'] ?? '',
      retorno['uf'] ?? '',
      retorno['unidade'] ?? '',
      retorno['ibge'] ?? '',
      retorno['gia'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cep": cep,
      "logradouro": logradouro,
      "complemento": complemento,
      "bairro": bairro,
      "localidade": localidade,
      "uf": uf,
      "unidade": unidade,
      "ibge": ibge,
      "gia": gia,
    };
  }
}
