import 'package:flutter/material.dart';

class CadastroAnimalPage extends StatefulWidget {
  final String title;
  const CadastroAnimalPage({Key? key, this.title = 'CadastroAnimalPage'}) : super(key: key);
  @override
  CadastroAnimalPageState createState() => CadastroAnimalPageState();
}
class CadastroAnimalPageState extends State<CadastroAnimalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}