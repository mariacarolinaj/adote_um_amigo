import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseService extends StatefulWidget {
  @override
  _DataBaseServiceState createState() => _DataBaseServiceState();
}

class _DataBaseServiceState extends State<DataBaseService> {
  _getDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco3.bd");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome VARCHAR, "
          "idade INTEGER, "
          "email VARCHAR, "
          "password VARCHAR); "
          "CREATE TABLE pet (id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome VARCHAR, "
          "age INTEGER, "
          "raca VARCHAR, "
          "caracteristicas VARCHAR, "
          "foto VARCHAR,"
          "usuarioID INTEGER); ";
      db.execute(sql);
    });
    return bd;
    //print("aberto: " + bd.isOpen.toString() );
  }

  _setUserData(String nome, int idade) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosUsuario = {"nome": nome, "idade": idade};
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");
  }

  _listUsers() async {
    Database bd = await _getDB();
    String sql = "SELECT * FROM usuarios";
    //String sql = "SELECT * FROM usuarios WHERE idade=58";
    //String sql = "SELECT * FROM usuarios WHERE idade >=30 AND idade <=58";
    //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 18 AND 58";
    //String sql = "SELECT * FROM usuarios WHERE nome='Maria Silva'";
    List usuarios = await bd.rawQuery(sql);
    for (var usu in usuarios) {
      print(" id: " +
          usu['id'].toString() +
          " nome: " +
          usu['nome'] +
          " idade: " +
          usu['idade'].toString());
    }
  }

  _listUserWithId(int id) async {
    Database bd = await _getDB();
    List usuarios = await bd.query("usuarios",
        columns: ["id", "nome", "idade"], where: "id = ?", whereArgs: [id]);
    for (var usu in usuarios) {
      print(" id: " +
          usu['id'].toString() +
          " nome: " +
          usu['nome'] +
          " idade: " +
          usu['idade'].toString());
    }
  }

  _removeUser(int id) async {
    Database bd = await _getDB();
    int retorno = await bd.delete("usuarios", where: "id = ?", whereArgs: [id]);
    print("Itens excluidos: " + retorno.toString());
  }

  _putUserData(int id, String name, int age) async {
    Database bd = await _getDB();
    Map<String, dynamic> dadosUsuario = {
      "nome": name,
      "idade": age,
    };
    int retorno = await bd
        .update("usuarios", dadosUsuario, where: "id = ?", whereArgs: [id]);
    print("Itens atualizados: " + retorno.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
