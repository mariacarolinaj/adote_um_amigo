import 'package:adote_um_amigo/app/shared/rotas.dart';
import 'package:flutter/material.dart';
import 'app/cadastros/cadastro-animal_page.dart';

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
        primarySwatch: Colors.blue,
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroAnimal),
        child: const Icon(Icons.add),
      ),
    );
  }
}
