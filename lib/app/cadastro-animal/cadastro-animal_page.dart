import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/style.dart';

class CadastroAnimalPage extends StatefulWidget {
  final String title;
  const CadastroAnimalPage({Key? key, this.title = 'CadastroAnimalPage'})
      : super(key: key);
  @override
  CadastroAnimalPageState createState() => CadastroAnimalPageState();
}

class CadastroAnimalPageState extends State<CadastroAnimalPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CarouselController _buttonCarouselController = CarouselController();
  int _carouselCurrentIndex = -1;
  Animal _animal = Animal();
  File? _fotoAtualCarousel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          children: <Widget>[_buildTitulo(), _buildForm()],
        ),
      ),
    );
  }

  Widget _buildTitulo() {
    return RichText(
      text: const TextSpan(
        text: 'Cadastro do ',
        style: TextStyle(
            color: Cores.titulo,
            fontSize: 32,
            fontFamily: 'Jost',
            fontStyle: FontStyle.normal),
        children: <TextSpan>[
          TextSpan(
              text: 'animal', style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldNome(),
          Row(
            children: [
              _buildFieldRaca(),
              _buildFieldIdade(),
            ],
          ),
          _buildFieldCaracteristicas(),
          _buildFieldVacinas(),
          if (_animal.fotos.isNotEmpty) _buildCarouselFotos(),
          _buildImagePicker(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildFieldNome() {
    return TextFormField(
      style: const TextStyle(
          color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Nome',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira o nome do animal';
        }
        _animal.nome = value;
        return null;
      },
    );
  }

  Widget _buildFieldRaca() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        style: const TextStyle(
            color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Raça',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira a raça';
          }
          _animal.raca = value;
          return null;
        },
      ),
    );
  }

  Widget _buildFieldIdade() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.only(left: 32.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(
            color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Idade',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira a idade';
          }
          _animal.idade = int.parse(value);
          return null;
        },
      ),
    );
  }

  Widget _buildFieldCaracteristicas() {
    return TextFormField(
      style: const TextStyle(
          color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Características',
      ),
      maxLines: 5,
      minLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira algumas características do bichinho, como personalidade, cor...';
        }
        _animal.caracteristicas = value;
        return null;
      },
    );
  }

  Widget _buildFieldVacinas() {
    return TextFormField(
      style: const TextStyle(
          color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Vacinas',
      ),
      maxLines: 5,
      minLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira algumas informações sobre o estado vacinal do animal';
        }
        _animal.vacinas = value;
        return null;
      },
    );
  }

  Widget _buildImagePicker() {
    return TextButton(
      onPressed: _animal.fotos.length < 5 ? _buildPhotoSourceDialog : null,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_circle_outline_rounded,
                color: Cores.textoBotaoSecundario),
            Text(
              '   Adicionar foto',
              style: TextStyle(color: Cores.textoBotaoSecundario, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _buildPhotoSourceDialog() async {
    switch (await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Adicionar fotos'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Abrir galeria'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Abrir Câmera'),
              ),
            ],
          );
        })) {
      case true:
        _getFotoGaleria();
        break;
      case false:
        _getFotoCamera();
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

  void _getFotoGaleria() async {
    PickedFile? foto = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (foto != null) {
      setState(() {
        _animal.fotos.add(File(foto.path));
        // _carouselIndex++;
      });
    }
  }

  void _getFotoCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _animal.fotos.add(File(pickedFile.path));
        // _carouselIndex = _animal.fotos.length - 1;
      });
    }
  }

  Widget _buildCarouselFotos() {
    return Column(children: <Widget>[
      CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          // initialPage: _animal.fotos.length - 1,
        ),
        carouselController: _buttonCarouselController,
        items: _animal.fotos.map((foto) {
          _fotoAtualCarousel = foto;
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Image(image: FileImage(foto)),
              );
            },
          );
        }).toList(),
      ),
      _buildButtonBar(),
    ]);
  }

  Row _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Foto anterior',
          onPressed: _animal.fotos.length > 1
              ? () {
                  _buttonCarouselController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              : null,
        ),
        IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Cores.erro,
          ),
          tooltip: 'Remover foto atual',
          onPressed: () {
            setState(() {
              _animal.fotos.remove(_fotoAtualCarousel);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Próxima foto',
          onPressed: _animal.fotos.length > 1
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

  Widget _buildButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Cores.primaria,
            fixedSize: const Size.fromWidth(300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          child: const Text(
            'Cadastrar',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processando os dados')),
                // fazer upload
              );
            }
          },
        ),
      ),
    );
  }
}
