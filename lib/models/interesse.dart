import 'package:adote_um_amigo/models/usuario.dart';
import 'package:adote_um_amigo/shared/db_service.dart';

import 'animal.dart';

class Interesse {
  late int id;
  late Animal animal;
  late Usuario interessado;

  Interesse.empty();

  Interesse(this.id, this.animal, this.interessado);

  Interesse.fromMap(Map<String, dynamic> map) {
    DataBaseService().getFotosByAnimalId(map["animalId"]).then((fotosAnimal) {
      id = map["id"];
      animal = Animal(
          map["animalId"],
          map["animalNome"],
          map["animalRaca"],
          map["animalCaracteristicas"],
          map["animalVacinas"],
          map["animalIdade"],
          fotosAnimal,
          map["animalDonoId"],
          map["animalTipo"]);
      interessado = Usuario(
          map["UserId"],
          map["UserNome"],
          map["UserEmail"],
          map["UserPassword"],
          map["UserLatGeo"],
          map["UserLonGeo"],
          map["UserTelefone"],
          map["UserImagemPerfil"],
          map["UserImagemCapa"],
          map["UserApresentacao"]);
    });
  }
}
