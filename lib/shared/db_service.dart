import 'dart:convert';
import 'dart:developer';

import 'package:adote_um_amigo/models/interesse.dart';
import 'package:adote_um_amigo/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/animal.dart';

class DataBaseService {
  Future<Database> _getDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.bd");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) async {
      String tableUsuario =
          "CREATE TABLE usuario (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome TEXT, "
          "email TEXT, "
          "imagemPerfil TEXT, "
          "imagemCapa TEXT, "
          "apresentacao TEXT, "
          "password TEXT, "
          "latGeo REAL, "
          "lonGeo REAL, "
          "telefone TEXT); ";
      String tableAnimal =
          "CREATE TABLE animal (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome TEXT, "
          "idade INTEGER, "
          "raca TEXT, "
          "tipo TEXT, "
          "caracteristicas TEXT, "
          "vacinas TEXT, "
          "donoId INTEGER); ";
      String tableInteresse =
          "CREATE TABLE interesse (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "petId INTEGER, "
          "interessadoId INTEGER);";
      String tableFotos =
          "CREATE TABLE fotos (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "petId INTEGER, "
          "foto String);";

      await db.execute(tableUsuario);
      await db.execute(tableAnimal);
      await db.execute(tableInteresse);
      await db.execute(tableFotos);
    });

    return bd;
  }

  Future<int> insertUser(Usuario pessoa) async {
    Database bd = await _getDB();
    Map<String, dynamic> dados = {
      "nome": pessoa.nome,
      "email": pessoa.email,
      "imagemPerfil": pessoa.imagemPerfil,
      "imagemCapa": pessoa.imagemCapa,
      "apresentacao": pessoa.apresentacao,
      "password": pessoa.password,
      "latGeo": pessoa.latGeo,
      "lonGeo": pessoa.lonGeo,
      "telefone": pessoa.telefone
    };

    int id = await bd.insert("usuario", dados);

    print("Usuário inserido. (ID: $id)");

    return id;
  }

  Future<int> insertAnimal(Animal animal) async {
    Database bd = await _getDB();
    Map<String, dynamic> dados = {
      "nome": animal.nome,
      "idade": animal.idade,
      "raca": animal.raca,
      "tipo": animal.tipo,
      "caracteristicas": animal.caracteristicas,
      "vacinas": animal.vacinas,
      "donoId": animal.donoId
    };

    int animalId = await bd.insert("animal", dados);

    animal.fotos.map((foto) async => await insertFotoAnimal(foto, animalId));

    log("Animal inserido. (ID: $animalId)");

    return animalId;
  }

  Future<int> insertFotoAnimal(String foto, int petId) async {
    Database bd = await _getDB();
    Map<String, dynamic> dados = {"foto": foto, "petId": petId};

    int fotoId = await bd.insert("fotos", dados);

    log("Foto inserida. (ID: $fotoId)");

    return fotoId;
  }

  Future<int> insertInteresse(int interessadoId, int petId) async {
    Database bd = await _getDB();
    Map<String, dynamic> dados = {
      "interessadoId": interessadoId,
      "petId": petId
    };

    int interesseId = await bd.insert("interesse", dados);

    log("Interesse inserido. (ID: $interesseId)");

    return interesseId;
  }

  Future<Usuario> getUserById(int id) async {
    Database bd = await _getDB();
    var response = await bd.query("usuario",
        columns: [
          "id",
          "nome",
          "email",
          "imagemPerfil",
          "imagemCapa",
          "apresentacao",
          "password",
          "latGeo",
          "lonGeo",
          "telefone"
        ],
        where: "id = ?",
        whereArgs: [id]);

    Usuario user = Usuario.fromMap(response.first);

    log("Resultado da busca pelo usuário by id:");
    inspect(user);

    return user;
  }

  Future<Usuario> getUserByEmailESenha(String email, String senha) async {
    Database bd = await _getDB();
    var response = await bd.query("usuario",
        columns: [
          "id",
          "nome",
          "email",
          "imagemPerfil",
          "imagemCapa",
          "apresentacao",
          "password",
          "latGeo",
          "lonGeo",
          "telefone"
        ],
        where: "email = ? and password = ?",
        whereArgs: [email, senha]);

    if (response.isEmpty) {
      log("Resultado da busca pelo usuário por email e senha não retornou resultado");
      return Usuario.empty();
    }

    Usuario user = Usuario.fromMap(response.first);

    log("Resultado da busca pelo usuário by email e senha:");
    inspect(user);

    return user;
  }

  Future<List<Animal>> getAllAnimal() async {
    Database bd = await _getDB();
    String sql = "SELECT a.id, "
        "a.nome, "
        "a.idade, "
        "a.raca, "
        "a.tipo, "
        "a.caracteristicas, "
        "a.vacinas, "
        "a.donoId, "
        "f.foto "
        "FROM animal a "
        "LEFT JOIN fotos f "
        "ON a.id = f.petId";

    var response = await bd.rawQuery(sql);

    var animais = _mapFotosAnimal(response);

    log("Resultado da busca por todos os animais:");
    inspect(animais);

    return animais;
  }

  Future<List<Animal>> getAnimalByUserId(int id) async {
    Database bd = await _getDB();
    String sql = "SELECT a.id, "
        "a.nome, "
        "a.idade, "
        "a.raca, "
        "a.tipo, "
        "a.caracteristicas, "
        "a.vacinas, "
        "a.donoId, "
        "f.foto "
        "FROM animal a "
        "LEFT JOIN fotos f "
        "ON a.id = f.petId "
        "WHERE a.donoId = $id";

    var response = await bd.rawQuery(sql);
    var animais = _mapFotosAnimal(response);

    log("Resultado da busca por todos os animais by userId:");
    inspect(animais);

    return animais;
  }

  List<Animal> _mapFotosAnimal(List<Map<String, Object?>> response) {
    List<Animal> animais = <Animal>[];
    for (var map in response) {
      var index = animais.indexWhere((a) => a.id == map["id"]);
      if (index >= 0) {
        animais[index].fotos.add(map["foto"] as String);
      } else {
        animais.add(Animal.fromMap(map));
      }
    }

    return animais;
  }

  Future<List<Interesse>> getInteressadosByDonoAnimalId(int id) async {
    Database bd = await _getDB();
    String sql = "SELECT i.id, "
        "a.id as animalId, "
        "a.nome as animalNome, "
        "a.idade as animalIdade, "
        "a.raca as animalRaca, "
        "a.tipo as animalTipo, "
        "a.caracteristicas as animalCaracteristicas, "
        "a.vacinas as animalVacinas, "
        "a.donoId as animalDonoId, "
        "u.id as UserId, "
        "u.nome as UserNome, "
        "u.email as UserEmail, "
        "u.imagemPerfil as UserImagemPerfil, "
        "u.imagemCapa as UserImagemCapa, "
        "u.apresentacao as UserApresentacao, "
        "u.password as UserPassword, "
        "u.latGeo as UserLatGeo, "
        "u.lonGeo as UserLonGeo, "
        "u.telefone as UserTelefone "
        "FROM interesse i "
        "INNER JOIN animal a "
        "ON a.id = i.petId "
        "INNER JOIN usuario u "
        "ON u.id = i.interessadoId "
        "WHERE a.donoId = $id";

    var response = await bd.rawQuery(sql);
    var interessados =
        response.map((interesse) => Interesse.fromMap(interesse)).toList();

    log("Resultado da busca por todos os interessados by donoId:");
    inspect(interessados);

    return interessados;
  }

  Future<List<Interesse>> getInteressesByUserId(int id) async {
    Database bd = await _getDB();
    String sql = "SELECT i.id, "
        "a.id as animalId, "
        "a.nome as animalNome, "
        "a.idade as animalIdade, "
        "a.raca as animalRaca, "
        "a.tipo as animalTipo, "
        "a.caracteristicas as animalCaracteristicas, "
        "a.vacinas as animalVacinas, "
        "a.donoId as animalDonoId, "
        "u.id as UserId, "
        "u.nome as UserNome, "
        "u.email as UserEmail, "
        "u.imagemPerfil as UserImagemPerfil, "
        "u.imagemCapa as UserImagemCapa, "
        "u.apresentacao as UserApresentacao, "
        "u.password as UserPassword, "
        "u.latGeo as UserLatGeo, "
        "u.lonGeo as UserLonGeo, "
        "u.telefone as UserTelefone "
        "FROM interesse i "
        "INNER JOIN animal a "
        "ON a.id = i.petId "
        "INNER JOIN usuario u "
        "ON u.id = i.interessadoId "
        "WHERE u.id = $id";

    var response = await bd.rawQuery(sql);
    var interesses =
        response.map((interesse) => Interesse.fromMap(interesse)).toList();

    log("Resultado da busca por todos os interesses by userId:");
    inspect(interesses);

    return interesses;
  }

  Future<List<String>> getFotosByAnimalId(int id) async {
    Database bd = await _getDB();
    var response = await bd.query("fotos",
        columns: ["foto"], where: "petId = ?", whereArgs: [id]);

    return response.map((ret) => ret["foto"] as String).toList();
  }

  Future<int> removeUser(int id) async {
    Database bd = await _getDB();
    int remocao = await bd.delete("usuario", where: "id = ?", whereArgs: [id]);

    log("Usuário removido. (ID: $remocao)");

    return remocao;
  }

  Future<int> removeAnimal(int id) async {
    Database bd = await _getDB();

    await bd.delete("interesse", where: "petId = ?", whereArgs: [id]);
    var remocao = await bd.delete("animal", where: "id = ?", whereArgs: [id]);

    log("Animal removido. (ID: $remocao)");

    return remocao;
  }

  Future<int> removeInteresse(int id) async {
    Database bd = await _getDB();

    var remocao =
        await bd.delete("interesse", where: "id = ?", whereArgs: [id]);
    log("Interesse removido. (ID: $remocao)");

    return remocao;
  }

  Future<void> deleteDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.bd");
    databaseFactory.deleteDatabase(localBancoDados);
    log("Base de dados deletada.");
  }

  Future<Usuario> getUsuarioLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('usuario');
    return Usuario.fromJson(jsonDecode(userString!) as Map<String, dynamic>);
  }
}
