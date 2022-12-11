import 'package:adote_um_amigo/models/tipo-animal-enum.dart';
import 'package:adote_um_amigo/shared/db_service.dart';

class Animal {
  late int id;
  late String nome;
  late String raca;
  late String caracteristicas;
  late String vacinas;
  late int idade;
  late var fotos = <String>[]; // base64
  late int donoId;
  late String tipo = TipoAnimal.Null;

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
    // DataBaseService().getFotosByAnimalId(id).then((value) => fotos = value);
  }
}
