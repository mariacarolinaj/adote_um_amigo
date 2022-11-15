import 'dart:developer';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/models/tipo-animal-enum.dart';
import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../shared/BarraNavegacaoInferior.dart';
import '../../shared/imagem_service.dart';
import '../../shared/style.dart';
import '../perfil-animal/perfil-animal_page.dart';

class ListagemAnimaisPage extends StatefulWidget {
  final String title;
  const ListagemAnimaisPage({Key? key, this.title = 'ListagemAnimaisPage'})
      : super(key: key);
  @override
  ListagemAnimaisPageState createState() => ListagemAnimaisPageState();
}

class ListagemAnimaisPageState extends State<ListagemAnimaisPage> {
  int _groupValue = 0;
  final List<String> _tiposAnimal = [
    TipoAnimal.Gato,
    TipoAnimal.Cachorro,
    TipoAnimal.Roedor,
    TipoAnimal.Outros
  ];
  Usuario _user = Usuario.empty();
  List<Animal> _animais = [];
  List<Animal> _animaisFiltro = [];

  @override
  initState() {
    super.initState();
    DataBaseService().getUsuarioLogado().then((result) {
      _user = result;
      setState(() {});
    });
    DataBaseService().getAllAnimal().then((value) {
      _animais = value;
      _animaisFiltro = _animais
          .where((animal) => animal.tipo == _tiposAnimal[_groupValue])
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildHeaderMessage(),
            _buildSegmentControl(),
            _buildAnimalsGrid(),
          ],
        ),
      ),
      // bottomNavigationBar: BarraNavegacaoInferior(),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 0, left: 23, right: 23),
      child: Row(
        children: [
          _buildTitleHeader(),
          _buildProfileImage(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).pushNamed(Rotas.perfilUsuario);
              },
              child: CircleAvatar(
                radius: 32,
                backgroundImage: _user.imagemPerfil.isEmpty
                    ? Image.network(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')
                        .image
                    : ImagemService().toImage(_user.imagemPerfil).image,
              )),
        ],
      ),
    );
  }

  Widget _buildTitleHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width * 0.65,
      child: RichText(
        text: TextSpan(
          text: 'Olá, ',
          style: const TextStyle(
              color: Cores.titulo,
              fontSize: 32,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal),
          children: <TextSpan>[
            TextSpan(
                text: _user.nome.split(" ").first,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderMessage() {
    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 24),
      child: RichText(
        text: const TextSpan(
          text: 'Qual tipo de pet está buscando?',
          style: TextStyle(
              color: Cores.titulo,
              fontSize: 17,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal),
        ),
      ),
    );
  }

  Widget buildSegment(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }

  Widget _buildSegmentControl() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1),
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: Cores.secondary,
        thumbColor: Colors.orangeAccent,
        padding: const EdgeInsets.all(8),
        groupValue: _groupValue,
        children: {
          0: buildSegment(_tiposAnimal[0]),
          1: buildSegment(_tiposAnimal[1]),
          2: buildSegment(_tiposAnimal[2]),
          3: buildSegment(_tiposAnimal[3]),
        },
        onValueChanged: (value) {
          setState(() {
            _groupValue = value ?? 0;
            _animaisFiltro = _animais
                .where((animal) => animal.tipo == _tiposAnimal[_groupValue])
                .toList();
            inspect(_animaisFiltro);
          });
        },
      ),
    );
  }

  Widget _buildAnimalsGrid() {
    return Container(
        child: _animaisFiltro.isNotEmpty
            ? Column(
                children: _animaisFiltro
                    .map(
                      (e) => buildAnimal(e),
                    )
                    .toList(),
              )
            : Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                    'Não existem pets desse tipo para adoção no momento'),
              ));
  }

  Widget _buildProfileImageAnimal(Animal animal) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, Rotas.listAnimals);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return PerfilAnimalPage(animal, false);
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: (animal.fotos.isEmpty
                  ? Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxYfkM0bPSesaofJe0efo9xNzn_-sa2L8RPg&usqp=CAU')
                      .image
                  : ImagemService().toImage(animal.fotos.first).image),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAnimal(Animal animal) {
    var idade = animal.idade;
    return ListTile(
      leading: _buildProfileImageAnimal(animal),
      title: Text(
        animal.nome,
        style: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'Raça ${animal.raca}, possui $idade anos de idade',
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
