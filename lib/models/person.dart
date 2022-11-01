import 'animal.dart';

class Person {
  late String nome;
  late String email;
  late String imagemPerfil;
  late String imagemCapa;
  late String apresentacao;
  late String password;
  late double latGeo;
  late double lonGeo;
  late int idPerson;
  late var animals = <Animal>[];
  late String telefone;

  Person.empty();

  Person(
      this.nome,
      this.email,
      this.password,
      this.latGeo,
      this.lonGeo,
      this.idPerson,
      this.telefone,
      this.animals,
      this.imagemPerfil,
      this.imagemCapa);
}
