import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:flutter/material.dart';
import 'app/cadastro-animal/cadastro-animal_page.dart';
import 'app/registro-usuario/login.dart';
import 'app/registro-usuario/criar-usuario.dart';
import 'app/perfil-animal/perfil-animal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light, // light mode
        primaryColor: Cores.primaria,
        fontFamily: 'Jost',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: Cores.titulo, fontSize: 32, fontStyle: FontStyle.normal),
          titleMedium: TextStyle(
              color: Cores.titulo, fontSize: 24, fontStyle: FontStyle.normal),
          titleSmall: TextStyle(
              color: Cores.titulo, fontSize: 16, fontStyle: FontStyle.normal),
          bodyMedium: TextStyle(
              color: Cores.texto, fontSize: 12, fontStyle: FontStyle.normal),
          bodySmall: TextStyle(
              color: Cores.texto, fontSize: 12, fontStyle: FontStyle.normal),
        ),
      ),
      home: const MyHomePage(title: 'Adote um Amigo'),
      // definir as rotas para cada página aqui
      routes: <String, WidgetBuilder>{
        Rotas.cadastroAnimal: (BuildContext context) =>
            const CadastroAnimalPage(title: 'Cadastro de Animal'),
        Rotas.loginUsuario: (BuildContext context) =>
            const loginUsuarioPage(title: 'Login de Usuario'),
        Rotas.registroUsuario: (BuildContext context) =>
            const RegisterPage(title: 'Cadastro de Usuario'),
        Rotas.perfilAnimal: (BuildContext context) =>
            const PerfilAnimalPage(title: 'Perfil Animal'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            //chamar a splash!!
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // exemplo de chamada de páginas através de rotas
        onPressed: () => Navigator.pushNamed(context, Rotas.loginUsuario),
        child: const Icon(Icons.add),
      ),
    );
  }
}
