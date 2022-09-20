import 'package:adote_um_amigo/app/perfil-animal/perfil-animal_page.dart';
import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:flutter/material.dart';
import 'app/cadastro-animal/cadastro-animal_page.dart';

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
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              Animal animal = Animal(
                  "Pitty",
                  "Pastor Alemão",
                  "Temperamento Docil, interage bem com outros animais e gosta de crianças.",
                  "vacinas vacinas vacinas",
                  5);
              return PerfilAnimalPage({animal: animal});
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
