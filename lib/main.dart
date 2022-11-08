import 'package:adote_um_amigo/app/listagem-animais/listagem-animais_page.dart';
import 'package:adote_um_amigo/app/meus-animais/meus-animais_page.dart';
import 'package:adote_um_amigo/shared/BarraNavegacaoInferior.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/cadastro-animal/cadastro-animal_page.dart';
import 'app/registro-usuario/login.dart';
import 'app/registro-usuario/criar-usuario.dart';
import 'app/perfil-usuario/perfil-usuario_page.dart';

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
        Rotas.perfilUsuario: (BuildContext context) =>
            const PerfilUsuarioPage(title: 'Perfil de usuario'),
        Rotas.meusAnimais: (BuildContext context) =>
            const MeusAnimaisPage(title: 'MeusAnimais'),
        Rotas.listAnimals: (BuildContext context) =>
            const ListagemAnimaisPage(),
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
    bool sessaoAtiva = false;
    return FutureBuilder<bool>(
      future: _isSessaoAtiva(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        sessaoAtiva = snapshot.data ?? false;
        return sessaoAtiva
            ? const ListagemAnimaisPage()
            : const loginUsuarioPage();
      },
    );
  }

  Future<bool> _isSessaoAtiva() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessaoAtiva = prefs.getBool('sessaoAtiva');
    return prefs.getBool('sessaoAtiva') ?? false;
  }
}
