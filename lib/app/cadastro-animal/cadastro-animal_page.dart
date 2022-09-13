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
  final _formKey = GlobalKey<FormState>();
  CarouselController buttonCarouselController = CarouselController();

  Animal animal = Animal();

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
          if (animal.fotos.isNotEmpty) _buildCarouselFotos(),
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
        animal.nome = value;
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
          animal.raca = value;
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
          animal.idade = int.parse(value);
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
        animal.caracteristicas = value;
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
        animal.vacinas = value;
        return null;
      },
    );
  }

  Widget _buildImagePicker() {
    return TextButton(
      onPressed: _buildPhotoSourceDialog,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_circle_outline_rounded,
                color: Cores.textoBotaoSecundario),
            Text(
              '   Adicionar fotos',
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
        print('------------------------------------------------------');
        print(this.animal.fotos.first);
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
        animal.fotos.add(File(foto.path));
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
        animal.fotos.add(File(pickedFile.path));
      });
    }
  }

  Widget _buildCarouselFotos() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
      carouselController: buttonCarouselController,
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              // width: MediaQuery.of(context).size.width * 0.2,
              // height: MediaQuery.of(context).size.height * 0.2,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.amber),
              child: Image(image: FileImage(animal.fotos.first)),
            );
          },
        );
      }).toList(),
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
