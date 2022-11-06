import 'package:adote_um_amigo/models/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/animal.dart';

class DataBaseService {
  _getDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.bd");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE usuario (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome TEXT, "
          "email TEXT, "
          "imagemPerfil TEXT, "
          "imagemCapa TEXT, "
          "apresentacao TEXT, "
          "password TEXT, "
          "latGeo REAL, "
          "lonGeo REAL, "
          "telefone TEXT); "
          "CREATE TABLE animal (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome TEXT, "
          "idade INTEGER, "
          "raca TEXT, "
          "tipo TEXT, "
          "caracteristicas TEXT, "
          "vacinas TEXT, "
          "donoId INTEGER); "
          "CREATE TABLE interesse (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "petId INTEGER, "
          "interessadoId INTEGER);"
          "CREATE TABLE fotos (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "petId INTEGER, "
          "foto String);";
      db.execute(sql);
    });
    return bd;
  }

  Future<int> insertUser(Usuario pessoa) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosUsuario = {
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
    return await bd.insert("usuario", dadosUsuario);
  }

  Future<int> insertAnimal(Animal animal) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosAnimal = {
      "nome": animal.nome,
      "idade": animal.idade,
      "raca": animal.raca,
      "tipo": animal.tipo,
      "caracteristicas": animal.caracteristicas,
      "vacinas": animal.vacinas,
      "donoId": animal.donoId
    };
    return await bd.insert("animal", dadosAnimal);
  }

  Future<int> insertFotoAnimal(String foto, int petId) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosFoto = {"foto": foto, "petId": petId};
    return await bd.insert("fotos", dadosFoto);
  }

  Future<int> insertInteresse(int interessadoId, int petId) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosFoto = {
      "interessadoId": interessadoId,
      "petId": petId
    };
    return await bd.insert("interesse", dadosFoto);
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
    return Usuario.fromMap(response.first);
  }

  Future<int> removeUser(int id) async {
    Database bd = await _getDB();
    int remocao = await bd.delete("usuarios", where: "id = ?", whereArgs: [id]);

    return remocao;
  }

  Future<int> removeAnimal(int id) async {
    Database bd = await _getDB();
    int remocaoOnUser =
        await bd.delete("animal", where: "id = ?", whereArgs: [id]);
    int remocaoOnAnimal =
        await bd.delete("interesse", where: "petId = ?", whereArgs: [id]);
    return remocaoOnUser;
  }

  Future<List<Animal>> getAllAnimal() async {
    Database bd = await _getDB();
    String sql =
        "SELECT a.id, a.nome, a.idade, a.raca, a.tipo, a.caracteristicas, a.vacinas, a.donoId, f.foto FROM animal a INNER JOIN fotos f ON a.id = f.petId";
    return await bd.rawQuery(sql) as List<Animal>;
  }

  Future<List<Animal>> getAnimalByUserId(int id) async {
    Database bd = await _getDB();
    return await bd.query("animal",
        columns: [
          "id",
          "nome",
          "idade",
          "raca",
          "tipo",
          "caracteristicas",
          "vacinas",
          "donoId"
        ],
        where: "donoId = ?",
        whereArgs: [id]) as List<Animal>;
  }

  Future<int> putUserData(int id, String name, int age) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosUsuario = {
      "nome": name,
      "idade": age,
    };
    return await bd
        .update("usuarios", dadosUsuario, where: "id = ?", whereArgs: [id]);
  }

// FALTA IMPLEMENTAR GET INTERESSES DOS MEUS ANIMAIS E MEUS ANIMAIS INTERESSADOS
}
