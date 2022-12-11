import 'package:adote_um_amigo/app/listagem-animais/listagem-animais_page.dart';
import 'package:adote_um_amigo/app/listagem-animais/listagem-animais_page2.dart';
import 'package:adote_um_amigo/app/meus-animais/meus-animais_page.dart';
import 'package:adote_um_amigo/shared/BarraNavegacaoInferior.dart';
import 'package:adote_um_amigo/app/tutorial/step_form.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/cadastro-animal/cadastro-animal_page.dart';
import 'app/meus-animais/animais-interesse_page.dart';
import 'app/registro-usuario/login.dart';
import 'app/registro-usuario/criar-usuario.dart';
import 'app/perfil-usuario/perfil-usuario_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool pularIntro = false;
    return FutureBuilder<bool>(
      future: _pularIntro(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        pularIntro = snapshot.data ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.light, // light mode
            primaryColor: Cores.primaria,
            fontFamily: 'Jost',
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                  color: Cores.titulo,
                  fontSize: 32,
                  fontStyle: FontStyle.normal),
              titleMedium: TextStyle(
                  color: Cores.titulo,
                  fontSize: 24,
                  fontStyle: FontStyle.normal),
              titleSmall: TextStyle(
                  color: Cores.titulo,
                  fontSize: 16,
                  fontStyle: FontStyle.normal),
              bodyMedium: TextStyle(
                  color: Cores.texto,
                  fontSize: 12,
                  fontStyle: FontStyle.normal),
              bodySmall: TextStyle(
                  color: Cores.texto,
                  fontSize: 12,
                  fontStyle: FontStyle.normal),
            ),
          ),
          home: pularIntro ? const loginUsuarioPage() : StepForm(),
          routes: <String, WidgetBuilder>{
            Rotas.cadastroAnimal: (BuildContext context) =>
                const CadastroAnimalPage(),
            Rotas.loginUsuario: (BuildContext context) =>
                const loginUsuarioPage(),
            Rotas.registroUsuario: (BuildContext context) =>
                const RegisterPage(),
            Rotas.perfilUsuario: (BuildContext context) =>
                const PerfilUsuarioPage(),
            Rotas.meusAnimais: (BuildContext context) =>
                const MeusAnimaisPage(),
            Rotas.listAnimals: (BuildContext context) =>
                const ListagemAnimaisPage(),
            Rotas.listAnimals2: (BuildContext context) =>
                const ListagemAnimaisPage2(),
            Rotas.animaisInteresse: (BuildContext context) =>
                const AnimaisInteressePage(),
          },
        );
      },
    );
  }

  Future<bool> _pularIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? pularIntro = prefs.getBool('pularIntro');
    return pularIntro ?? false;
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
            ? const ListagemAnimaisPage2()
            : const loginUsuarioPage();
      },
    );
  }

  Future<bool> _isSessaoAtiva() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessaoAtiva = prefs.getBool('sessaoAtiva');
    return sessaoAtiva ?? false;
  }
}
