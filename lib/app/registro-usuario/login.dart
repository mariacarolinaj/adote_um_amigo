import 'dart:convert';

import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:flutter/material.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/usuario.dart';

class loginUsuarioPage extends StatefulWidget {
  final String title;
  const loginUsuarioPage({Key? key, this.title = 'CadastroUsuarioPage'})
      : super(key: key);
  @override
  loginUsuarioPageState createState() => loginUsuarioPageState();
}

class loginUsuarioPageState extends State<loginUsuarioPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  var email, senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    _buildFieldEmail(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildFieldSenha(),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _validarLogin();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Rotas.registroUsuario);
                          },
                          child: const Text('Criar uma conta'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildFieldSenha() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira sua senha';
        }
        senha = value;

        return null;
      },
      maxLines: 1,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        hintText: 'Insira sua senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextFormField _buildFieldEmail() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Insira seu Email',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu e-mail';
        }
        email = value;

        return null;
      },
    );
  }

  _validarLogin() async {
    var user = await DataBaseService().getUserByEmailESenha(email, senha);
    if (user.nome == null || user.nome == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ops!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Não foi encontrado nenhum usuário com os dados informados.'),
                  Text('Tente novamente.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Voltar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      await _salvarDadosDeSessao(user);
      Navigator.pushNamed(
          context, Rotas.cadastroAnimal); // trocar pra rota da pag principal
    }
  }

  Future<void> _salvarDadosDeSessao(Usuario usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(usuario.toJson());
    await prefs.setString('usuario', userString);
    await prefs.setBool("sessaoAtiva", true);
  }
}
