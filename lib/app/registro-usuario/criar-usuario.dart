import 'package:adote_um_amigo/models/usuario.dart';
import 'package:adote_um_amigo/models/result_cep.dart';
import 'package:flutter/material.dart';
import 'package:adote_um_amigo/shared/rotas.dart';
import 'package:adote_um_amigo/shared/style.dart';
import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adote_um_amigo/service/via_cep_service.dart';

import '../../shared/imagem_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final Usuario _user = Usuario.empty();
  TextEditingController dataCEP = TextEditingController();
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Cadastro',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildFieldNome(),
                            ),
                          ],
                        ),
                        _spacer(),
                        _buildFieldTelefone(),
                        _spacer(),
                        _buildFieldEmail(),
                        _spacer(),
                        _buildFieldCep(),
                        _spacer(),
                        _buildResultForm(),
                        _spacer(),
                        _buildFieldSenha(),
                        _spacer(),
                        _buildFieldApresentacao(),
                        _spacer(),
                        _imagemPerfil(),
                        _spacer(),
                        _buildButtonCadastrar(),
                        _spacer(),
                        _buildInfoEntrar(),
                        _spacer(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _spacer() {
    return const SizedBox(
      height: 20,
    );
  }

  Row _buildInfoEntrar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Já possui uma conta?'),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Rotas.loginUsuario);
          },
          child: const Text('Entrar'),
        ),
      ],
    );
  }

  Widget _buildButtonCadastrar() {
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
              onPressed: _cadastrar,
              child: const Text(
                'Cadastrar',
                style: TextStyle(fontSize: 16),
              )),
        ),
      ),
    );
  }

  _cadastrar() {
    DataBaseService().insertUser(_user);
    Navigator.pushNamed(context, Rotas.loginUsuario);
  }

  TextFormField _buildFieldSenha() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Senha';
        }
        if (value.length < 8) {
          return 'A senha deve conter no mínimo 8 caracteres';
        }
        _user.password = value;
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
      maxLines: 1,
      obscureText: true,
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: 'Insira uma senha',
        border: UnderlineInputBorder(),
      ),
    );
  }

  TextFormField _buildFieldCep() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.number,
      style: Style().inputTextStyle,
      controller: dataCEP,
      onChanged: (String value) async {
        if (value.length == 8) {
          _searchCep();
        }
      },
      decoration: const InputDecoration(
        hintText: 'CEP',
        prefixIcon: Icon(Icons.pin),
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'CEP = 00000000';
        }
        if (value.length < 8) {
          return 'O CEP deve conter 8 digitos';
        }
        _user.latGeo = double.parse(value);
        return null;
      },
    );
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(_result ?? ''),
    );
  }

  TextFormField _buildFieldEmail() {
    return TextFormField(
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        hintText: 'E-mail',
        prefixIcon: Icon(Icons.email),
        border: UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu e-mail';
        }
        if (!_emailValidator(value)) {
          return 'E-mail inválido';
        }
        _user.email = value;
        return null;
      },
    );
  }

  bool _emailValidator(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(email);
  }

  TextFormField _buildFieldNome() {
    return TextFormField(
      maxLines: 1,
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        hintText: 'Nome',
        prefixIcon: Icon(Icons.person),
        border: UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu nome';
        }
        _user.nome = value;
        return null;
      },
    );
  }

  TextFormField _buildFieldTelefone() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.phone,
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        hintText: 'Telefone',
        prefixIcon: Icon(Icons.phone),
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu telefone';
        }
        if (value.length < 11) {
          return 'Informe seu telefone completo com DDD';
        }
        _user.telefone = value;
        return null;
      },
    );
  }

  Widget _buildFieldApresentacao() {
    return TextFormField(
      maxLength: 300,
      style: Style().inputTextStyle,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.star),
        border: UnderlineInputBorder(),
        labelText: 'Sobre você',
      ),
      keyboardType: TextInputType.text,
      maxLines: 3,
      minLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira uma breve apresentação sobre você';
        }
        _user.apresentacao = value;
        return null;
      },
    );
  }

  Widget _imagemPerfil() {
    return Column(
      children: [
        _user.imagemPerfil.isNotEmpty ? _buildProfileImage() : Container(),
        _buildImagePicker()
      ],
    );
  }

  Widget _buildProfileImage() => CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: ImagemService().toImage(_user.imagemPerfil).image,
      );

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextButton(
        onPressed: _buildPhotoSourceDialog,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.image, color: Cores.textoBotaoSecundario),
              Text(
                '   Escolher foto do perfil',
                style:
                    TextStyle(color: Cores.textoBotaoSecundario, fontSize: 14),
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
          title: Text(
            'Escolher foto',
            textAlign: TextAlign.center,
            style: Style().inputTextStyle,
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
        break;
    }
  }

  void _getFotoCamera() async {
    PickedFile? foto = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (foto != null) {
      setState(
        () {
          String base64Image = ImagemService().toBase64(foto);
          _user.imagemPerfil = base64Image;
        },
      );
    }
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
          String base64Image = ImagemService().toBase64(foto);
          _user.imagemPerfil = base64Image;
        },
      );
    }
  }

  void _searchCep() async {
    final cep = dataCEP.text;
    final resultCep = await ViaCepService.fetchCep(cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal
    setState(() {
      _result = resultCep.localidade;
    });
  }
}
