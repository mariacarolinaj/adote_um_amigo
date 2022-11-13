import 'package:adote_um_amigo/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:adote_um_amigo/shared/db_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conUserPassword = TextEditingController();
  final _conUserEmail = TextEditingController();
  var rememberValue = false;
  var DbHelper = DataBaseService();

  singUp() {
    Usuario uModel =
        Usuario(0, 'Luana', 'Luana', '123456', 0, 0, '', '', '', '');
    DbHelper.insertUser(uModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cadastro',
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          controller: _conUserName,
                          decoration: InputDecoration(
                            hintText: 'Nome Completo',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _conUserEmail,
                    decoration: InputDecoration(
                      hintText: 'Insira seu email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _conUserPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira uma senha';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Insira uma senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: singUp(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Cadastrar',
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
                      const Text('Já possui uma conta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Rotas.loginUsuario);
                        },
                        child: const Text('Entrar'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
