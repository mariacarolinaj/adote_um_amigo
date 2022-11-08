import 'dart:convert';
import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/tipo-animal-enum.dart';
import '../../shared/style.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/app/perfil-animal/perfil-animal_page.dart';

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
  final Animal _animal = Animal.empty();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  _buildTitulo(),
                  Expanded(child: _buildForm()),
                  _buildButton(),
                ],
              ),
            ),
          ],
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
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldNome(),
          _buildFieldTipo(),
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

  Widget _buildFieldTipo() {
    return DropdownButtonFormField(
      value: _animal.tipo,
      hint: const Text('Tipo',
          style: TextStyle(
              color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal)),
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          _animal.tipo = value.toString();
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Escolha um tipo";
        } else {
          return null;
        }
      },
      items: TipoAnimal().toList().map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(
            val,
            style: const TextStyle(
                color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
          ),
        );
      }).toList(),
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
    bool isDisabled = _animal.fotos.length == 5;
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextButton(
        onPressed: !isDisabled ? _buildPhotoSourceDialog : null,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline_rounded,
                  color:
                      !isDisabled ? Cores.textoBotaoSecundario : Colors.grey),
              Text(
                '   Adicionar foto',
                style: TextStyle(
                    color:
                        !isDisabled ? Cores.textoBotaoSecundario : Colors.grey,
                    fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildPhotoSourceDialog() async {
    switch (await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Adicionar fotos',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Cores.titulo, fontSize: 16, fontStyle: FontStyle.normal),
          ),
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    child: const Text(
                      "Galeria",
                      style: TextStyle(color: Cores.texto),
                    ),
                  ),
                  const SizedBox(width: 32),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    child: const Text(
                      "Câmera",
                      style: TextStyle(color: Cores.texto),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    )) {
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

  String _convertImageToBase64(PickedFile foto) {
    File imagem = File(foto.path);
    final bytes = imagem.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  void _getFotoGaleria() async {
    PickedFile? foto = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (foto != null) {
      setState(
        () {
          String base64Image = _convertImageToBase64(foto);
          _animal.fotos.add(base64Image);
          if (_animal.fotos.length > 1) {
            _buttonCarouselController.animateToPage(_animal.fotos.length - 1);
          }
        },
      );
    }
  }

  void _getFotoCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(
        () {
          String base64Image = _convertImageToBase64(pickedFile);
          _animal.fotos.add(base64Image);

          if (_animal.fotos.length > 1) {
            _buttonCarouselController.animateToPage(_animal.fotos.length - 1);
          }
        },
      );
    }
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
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            carouselController: _buttonCarouselController,
            items: _animal.fotos.map(
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
              _animal.fotos.removeAt(_currentIndex);
              if (_currentIndex == 1 && _animal.fotos.length == 1) {
                _currentIndex = 0;
              }
            });
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.chevron_right,
          ),
          color: Cores.primaria,
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
              'Cadastrar',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                DataBaseService().insertAnimal(_animal);
                Navigator.pushNamed(context, Rotas.listAnimals);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return PerfilAnimalPage(_animal);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
