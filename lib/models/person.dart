import 'animal.dart';

class Person {
  late int id;
  late String nome;
  late String email;
  late String imagemPerfil;
  late String imagemCapa;
  late String apresentacao;
  late String password;
  late double latGeo;
  late double lonGeo;
  late var animais = <Animal>[];
  late String telefone;

  Person.empty();

  Person(
      this.id,
      this.nome,
      this.email,
      this.password,
      this.latGeo,
      this.lonGeo,
      this.telefone,
      this.animais,
      this.imagemPerfil,
      this.imagemCapa,
      this.apresentacao);

  Person.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nome = map["nome"];
    email = map["email"];
    imagemPerfil = map["imagemPerfil"];
    imagemCapa = map["imagemCapa"];
    apresentacao = map["apresentacao"];
    password = map["password"];
    latGeo = map["latGeo"];
    lonGeo = map["lonGeo"];
    telefone = map["telefone"];
  }
}
