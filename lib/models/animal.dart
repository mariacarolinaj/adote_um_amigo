class Animal {
  late int id;
  late String nome;
  late String raca;
  late String caracteristicas;
  late String vacinas;
  late int idade;
  late var fotos = <String>[]; // base64
  late String donoId;
  late String tipo;

  Animal.empty();

  Animal(this.id, this.nome, this.raca, this.caracteristicas, this.vacinas,
      this.idade, this.fotos, this.tipo);
}
