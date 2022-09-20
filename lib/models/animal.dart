import 'dart:io';

class Animal {
  late String nome;
  late String raca;
  late String caracteristicas;
  late String vacinas;
  late int idade;
  late var fotos = <File>[];

  Animal.empty() {}

  Animal(String nome, String raca, String caracteristicas, String vacinas, int idade, var fotos) {
    this.nome = nome;
    this.raca = raca;
    this.caracteristicas = caracteristicas;
    this.vacinas = vacinas;
    this.idade = idade;
    this.fotos = fotos;
  }
}
