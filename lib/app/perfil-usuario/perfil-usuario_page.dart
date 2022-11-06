import 'dart:developer';
import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:adote_um_amigo/models/usuario.dart';
import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/BarraNavegacaoInferior.dart';
import '../../shared/rotas.dart';
import '../../shared/style.dart';
import 'NumbersWidget.dart';

class PerfilUsuarioPage extends StatefulWidget {
  final String title;

  const PerfilUsuarioPage({Key? key, this.title = 'PerfilUsuarioPage'})
      : super(key: key);

  @override
  PerfilUsuarioPageState createState() => PerfilUsuarioPageState();
}

class PerfilUsuarioPageState extends State<PerfilUsuarioPage> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  Usuario user = Usuario as Usuario;

  Future<Usuario> getUser () async {
    final fUser = await DataBaseService().getUserById(1);
    return fUser;
  }

  @override
  Widget build(BuildContext context) {
    getUser().then((value) =>
        debugPrint('usuario: $value')
        // user = value
    ).catchError((error, stackTrace) {
      print("erro usuario: $error");
    });


    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
      // bottomNavigationBar: BarraNavegacaoInferior(),
    );
  }

  //funcao para alihar as fotos de capa e perfil
  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        )
      ],
    );
  }

  //imagem do fundo/ capa
  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://i.pinimg.com/originals/c2/da/7a/c2da7af65cbcfaff6f7582d6a0b79781.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      ); //Container

  //imagem de perfil/ avatar
  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
          'https://cdn.pixabay.com/photo/2018/01/06/09/25/hijab-3064633_960_720.jpg',
        ),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Ana',
            // user.nome,
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            child: Text(
              'Somos uma instituição de caridade, onde nosso proposito é buscar animais que foram abonados e encontar um novo lar para os animaiszinhos!',
              // user.apresentacao,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(left: 32, right: 32),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesomeIcons.dog, Rotas.meusAnimais),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesomeIcons.searchLocation,
                  Rotas.meusAnimais), //adicionar rota de localizacao
              SizedBox(width: 12),
              buildSocialIcon(FontAwesomeIcons.star,
                  Rotas.meusAnimais), //adicionar rota de quantas estrelas
            ],
          ),
          const SizedBox(height: 16),
          Divider(),
          const SizedBox(height: 16),
          NumbersWidget(),
          const SizedBox(height: 16),
          Divider(),
          const SizedBox(height: 16),
          buildAbout(),
          const SizedBox(height: 32),
          buildMyAnimal(),
          const SizedBox(height: 32),
          _logout(),
        ],
      );

  //icones de informacao do usuario
  Widget buildSocialIcon(IconData icon, String rotas) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, rotas),
            child: Center(child: Icon(icon, size: 32)),
          ),
        ),
      );

  //botao para entrar em contato com um usuario
  Widget buildAbout() => Container(
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              elevation: 30,
              shadowColor: Colors.green),
          child: Text(
            'Entrar em contato',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () {}, //colocar rota do chat
        ),
      );

  //botao para meus animais de interesse *Futuramente colocar em um if para visao do usuario somente
  Widget buildMyAnimal() => Container(
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              elevation: 30,
              shadowColor: Colors.green),
          child: Text(
            'Meus animais de interesse',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () => Navigator.pushNamed(context, Rotas.meusAnimais),
        ),
      );

  Widget _logout() => Container(
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              elevation: 30,
              shadowColor: Colors.green),
          child: Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushNamed(context, Rotas.loginUsuario);
          },
        ),
      );
}
