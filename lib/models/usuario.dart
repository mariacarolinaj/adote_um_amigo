import 'animal.dart';

class Usuario {
  late int id = 0;
  late String nome = '';
  late String email = '';
  late String password = '';
  late String imagemPerfil = '';
  late String imagemCapa = '';
  late String apresentacao = '';
  late double latGeo = 0;
  late double lonGeo = 0;
  late String telefone = '';

  Usuario.empty();

  Usuario(
      this.id,
      this.nome,
      this.email,
      this.password,
      this.latGeo,
      this.lonGeo,
      this.telefone,
      this.imagemPerfil,
      this.imagemCapa,
      this.apresentacao);

  Usuario.fromMap(Map<String, dynamic> map) {
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

  factory Usuario.fromJson(Map<String, dynamic> parsedJson) {
    return Usuario(
        parsedJson['id'] ?? 0,
        parsedJson['nome'] ?? '',
        parsedJson['email'] ?? '',
        parsedJson['password'] ?? '',
        parsedJson['latGeo'] ?? 0,
        parsedJson['lonGeo'] ?? 0,
        parsedJson['telefone'] ?? '',
        parsedJson['imagemPerfil'] ?? '',
        parsedJson['imagemCapa'] ?? '',
        parsedJson['apresentacao'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "email": email,
      "password": password,
      "latGeo": latGeo,
      "lonGeo": lonGeo,
      "telefone": telefone,
      "imagemPerfil": imagemPerfil,
      "imagemCapa": imagemCapa,
      "apresentacao": apresentacao
    };
  }
}
