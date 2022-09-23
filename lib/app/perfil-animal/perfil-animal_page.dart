import 'dart:convert';
import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';

class PerfilAnimalPage extends StatefulWidget {
  final String title;
  final Animal animal;

  const PerfilAnimalPage(this.animal,
      {Key? key, this.title = 'PerfilAnimalPage'})
      : super(key: key);
  @override
  PerfilAnimalPageState createState() => PerfilAnimalPageState();
}

class PerfilAnimalPageState extends State<PerfilAnimalPage> {
  final CarouselController _buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[_buildCarouselFotos(), _buildSecaoInicial()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselFotos() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {});
              },
            ),
            carouselController: _buttonCarouselController,
            items: widget.animal.fotos.map(
              (foto) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.memory(const Base64Decoder().convert(foto)),
                    );
                  },
                );
              },
            ).toList(),
          ),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Row _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.chevron_left,
          ),
          color: Cores.primaria,
          tooltip: 'Foto anterior',
          onPressed: widget.animal.fotos.length > 1
              ? () {
                  _buttonCarouselController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              : null,
        ),
        IconButton(
          icon: const Icon(
            Icons.chevron_right,
          ),
          color: Cores.primaria,
          tooltip: 'Próxima foto',
          onPressed: widget.animal.fotos.length > 1
              ? () {
                  _buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildSecaoInicial() {
    return Column(
      children: <Widget>[
        _buildNome(),
        _buildCaracteristicas(),
      ],
    );
  }

  Widget _buildNome() {
    return RichText(
      text: TextSpan(
          text: widget.animal.nome,
          style: const TextStyle(
              color: Cores.titulo,
              fontSize: 24,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal),
          children: const <TextSpan>[]),
    );
  }

  Widget _buildCaracteristicas() {
    return RichText(
      text: TextSpan(
          text: widget.animal.caracteristicas,
          style: const TextStyle(
              color: Cores.titulo,
              fontSize: 16,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal),
          children: const <TextSpan>[]),
    );
  }

  // Widget _buildInformacoes() {
  //   return
  // }
}
