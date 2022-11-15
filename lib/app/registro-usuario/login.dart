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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        backgroundColor: Cores.primaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
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
                        const Text('Ainda não possui uma conta?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Rotas.registroUsuario);
                          },
                          child: const Text('Cadastre-se agora'),
                        ),
                      ],
                    )
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
      keyboardType: TextInputType.visiblePassword,
      maxLines: 1,
      obscureText: true,
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        border: UnderlineInputBorder(),
        hintText: 'Senha',
      ),
    );
  }

  TextFormField _buildFieldEmail() {
    return TextFormField(
      maxLines: 1,
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        hintText: 'E-mail',
        prefixIcon: Icon(Icons.email),
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu e-mail';
        }
        if (!_emailValidator(value)) {
          return 'E-mail inválido';
        }
        email = value;
        return null;
      },
    );
  }

  bool _emailValidator(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(email);
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
      Navigator.pushNamed(context, Rotas.listAnimals2);
    }
  }

  Future<void> _salvarDadosDeSessao(Usuario usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(usuario.toJson());
    await prefs.setString('usuario', userString);
    await prefs.setBool("sessaoAtiva", true);
  }
}
