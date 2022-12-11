import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/BarraNavegacaoInferior.dart';

class ListagemAnimaisPage2 extends StatefulWidget {
  final String title;

  const ListagemAnimaisPage2({Key? key, this.title = 'ListagemAnimaisPage'})
      : super(key: key);

  @override
  ListagemAnimaisPage2State createState() => ListagemAnimaisPage2State();
}

class ListagemAnimaisPage2State extends State<ListagemAnimaisPage2> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 32, left: 16, right: 16),
      ),
      bottomNavigationBar: BarraNavegacaoInferior(),
    );
  }
}
