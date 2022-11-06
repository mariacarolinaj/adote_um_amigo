class Animal {
  late int id;
  late String nome;
  late String raca;
  late String caracteristicas;
  late String vacinas;
  late int idade;
  late var fotos = <String>[]; // base64
  late int donoId;
  late String tipo;

  Animal.empty();

  Animal(this.id, this.nome, this.raca, this.caracteristicas, this.vacinas,
      this.idade, this.fotos, this.donoId, this.tipo);

  Animal.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nome = map["nome"];
    raca = map["raca"];
    caracteristicas = map["caracteristicas"];
    vacinas = map["vacinas"];
    idade = map["idade"];
    donoId = map["donoId"];
    tipo = map["tipo"];
  }
}
