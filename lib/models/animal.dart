class Animal {
  late String nome;
  late String raca;
  late String caracteristicas;
  late String vacinas;
  late int idade;
  late int idAnimal;
  late var fotos = <String>[]; // base64

  Animal.empty();

  Animal(this.idAnimal, this.nome, this.raca, this.caracteristicas,
      this.vacinas, this.idade, this.fotos);
}
