import 'dart:developer';
import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/models/tipo-animal-enum.dart';
import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/BarraNavegacaoInferior.dart';
import '../../shared/style.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      ),
      bottomNavigationBar: BarraNavegacaoInferior(),
    );
  }
}
