import 'package:http/http.dart' as http;
import 'package:adote_um_amigo/models/result_cep.dart';
import 'dart:convert';

class ViaCepService {
  static Future<ResultCep> fetchCep(String cep) async {
    var uri = Uri.parse("https://viacep.com.br/ws/${cep}/json/");
    http.Response response;
    response = await http.get(uri);
    if (response.statusCode == 200) {
      return ResultCep.fromJson(json.decode(response.body));
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
