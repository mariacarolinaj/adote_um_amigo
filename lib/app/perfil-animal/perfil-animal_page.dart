import 'dart:convert';
import 'dart:developer';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/models/usuario.dart';
import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';
import '../visual-perfil-usuario/visual-perfil-usuario.dart';
import 'package:adote_um_amigo/models/result_cep.dart';
import 'package:adote_um_amigo/service/via_cep_service.dart';

class PerfilAnimalPage extends StatefulWidget {
  final String title;
  final Animal animal;
  final bool exibicaoDoDono;

  const PerfilAnimalPage(this.animal, this.exibicaoDoDono,
      {Key? key, this.title = 'PerfilAnimalPage'})
      : super(key: key);
  @override
  PerfilAnimalPageState createState() => PerfilAnimalPageState();
}

class PerfilAnimalPageState extends State<PerfilAnimalPage> {
  final CarouselController _buttonCarouselController = CarouselController();
  Usuario _usuario = Usuario.empty();
  bool _interesseSalvo = false;
  String _resultCep = '';

  @override
  initState() {
    super.initState();
    DataBaseService().getUsuarioLogado().then((result) {
      _usuario = result;
      _methodToPrint();
      setState(() {});
    });
    DataBaseService()
        .checkInteresseExistente(_usuario.id, widget.animal.id)
        .then((value) {
      inspect(value);
      _interesseSalvo = value;
      // inspect(_interesseSalvo);
      setState(() {});
    });
  }

  void _searchCep(String cep) async {
    final resultCep = await ViaCepService.fetchCep(cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal
    _resultCep = resultCep.localidade;
    setState(() {});
  }

  void _methodToPrint() {
    int toInt = _usuario.latGeo.toInt();
    String toString = toInt.toString();
    _searchCep(toString);
  }

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
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        _buildCarouselFotos(),
                        _buildSecaoInicial(),
                        // _buildCardDistancia(),
                        _buildInformacoes(),
                        if (!widget.exibicaoDoDono && !_interesseSalvo)
                          _buildButtonSalvar(),
                        if (!widget.exibicaoDoDono) _buildButtonContato(),
                      ],
                    ),
                  ),
                  _buildButtonVoltar(),
                ],
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
                      child: Image.memory(const Base64Decoder().convert(foto),
                          gaplessPlayback: true),
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
        _buildTituloSecao(widget.animal.nome),
        _buildCaracteristicas(),
      ],
    );
  }

  Widget _buildTituloSecao(String tituloSecao) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Text(tituloSecao,
          style: const TextStyle(
              color: Cores.titulo,
              fontSize: 24,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal)),
    );
  }

  Widget _buildCaracteristicas() {
    return Text(widget.animal.caracteristicas,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Cores.titulo,
            fontSize: 16,
            fontFamily: 'Jost',
            fontStyle: FontStyle.normal));
  }

  Widget _buildCardDistancia() {
    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 16),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 211, 212, 255),
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(color: Cores.texto, fontSize: 18),
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.pin_drop_outlined,
                  size: 18,
                  color: Cores.texto,
                ),
              ),
              TextSpan(
                text: "  A ${_getDistancia()} de você",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformacoes() {
    return Column(
      children: [
        _buildTituloSecao("Informações"),
        Center(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _getTextInfoDescricao("Idade"),
                    _getTextInfoDescricao("Cidade"),
                    _getTextInfoDescricao("Vacinas")
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 1.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTextInfoValor("${widget.animal.idade} anos"),
                    _getTextInfoValor(_resultCep),
                    _getTextInfoValor(widget.animal.vacinas)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getTextInfoDescricao(String descricao) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        descricao,
        style: const TextStyle(
            color: Cores.titulo,
            fontSize: 16,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal),
      ),
    );
  }

  _getTextInfoValor(String valor) {
    return Text(
      valor,
      style: const TextStyle(
          color: Cores.titulo,
          fontSize: 16,
          fontFamily: 'Jost',
          fontStyle: FontStyle.normal),
    );
  }

  Widget _buildButtonContato() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 16),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Cores.primaria,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            child: const Text(
              'Perfil e contatos do tutor',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VisualPerfilUsuario(widget.animal.donoId),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSalvar() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, bottom: 16),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Cores.primaria,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            child: const Text(
              'Salvar interesse',
              style: TextStyle(fontSize: 16),
            ),
            // Botão que abre uma segunda tela mostrando o perfil do usuário
            onPressed: () {
              DataBaseService()
                  .insertInteresse(_usuario.id, widget.animal.id)
                  .then((value) {
                const snackBar = SnackBar(
                  content: Text('Interesse salvo com sucesso'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtonVoltar() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          width: 300,
          height: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            child: const Text(
              'Voltar',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            // Botão que abre uma segunda tela mostrando o perfil do usuário
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Rotas.listAnimals2));
            },
          ),
        ),
      ),
    );
  }

  String _getDistancia() {
    // implementar chamada à api para calculo da distancia
    return "5km";
  }
}
