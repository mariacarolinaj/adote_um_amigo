import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/BarraNavegacaoInferior.dart';
import '../../shared/style.dart';

class ListagemAnimaisPage extends StatefulWidget {
  final String title;
  const ListagemAnimaisPage({Key? key, this.title = 'ListagemAnimaisPage'})
      : super(key: key);
  @override
  ListagemAnimaisPageState createState() => ListagemAnimaisPageState();
}

class ListagemAnimaisPageState extends State<ListagemAnimaisPage> {
  int? groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          children: <Widget>[
            _buildHeader("Robson"),
            _buildHeaderMessage(),
            _buildSegmentControl(),
          ],
        ),
      ),
      // bottomNavigationBar: BarraNavegacaoInferior(),
    );
  }

  Widget _buildHeader(String name) {
    return Container(
      child: Row(
        children: [
          _buildTitleHeader(name),
          _buildProfileImage(),
        ],
      ),
      margin: const EdgeInsets.only(top: 24, bottom: 0, left: 23, right: 23),
    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).pushNamed(Rotas.perfilUsuario);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/media/EvHvTkCWQAA13pI.jpg'),
              )),
        ],
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }

  Widget _buildTitleHeader(String name) {
    return RichText(
      text: TextSpan(
        text: 'Ola,\n',
        style: TextStyle(
            color: Cores.titulo,
            fontSize: 32,
            fontFamily: 'Jost',
            fontStyle: FontStyle.normal),
        children: <TextSpan>[
          TextSpan(text: name, style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildHeaderMessage() {
    return Container(
      child: RichText(
        text: const TextSpan(
          text: 'Qual tipo de animal está buscando?',
          style: TextStyle(
              color: Cores.titulo,
              fontSize: 17,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal),
        ),
      ),
      margin: const EdgeInsets.only(top: 40),
    );
  }

  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  Widget _buildSegmentControl() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: Cores.secondary,
        thumbColor: Colors.yellow,
        padding: EdgeInsets.all(8),
        groupValue: groupValue,
        children: {
          0: buildSegment("Cão"),
          1: buildSegment("Gato"),
          2: buildSegment("Coelho"),
          3: buildSegment("Hamster")
        },
        onValueChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ),
    );
  }

  Widget _buildAnimalsGrid() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
      ],
    );
  }
}
