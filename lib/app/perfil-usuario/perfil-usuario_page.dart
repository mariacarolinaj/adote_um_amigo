import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
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
      'https://images.app.goo.gl/Qr6fW6UwoUhLMEMk9',
    ),
  );

  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8),
      Text(
        'Jonas',
        style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        'Somos uma instituição de caridade, onde nosso proposito é buscar animais que foram abonados e encontar um novo lar para os animaiszinhos!',
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
      ),

      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialIcon(FontAwesomeIcons.dog),
          SizedBox(width: 12),
          buildSocialIcon(FontAwesomeIcons.searchLocation),
          SizedBox(width: 12),
          buildSocialIcon(FontAwesomeIcons.star),
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
    ],
  );

  //icones de informacao do usuario
  Widget buildSocialIcon(IconData icon) => CircleAvatar(
    radius: 25,
    child: Material(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Center(child: Icon(icon, size: 32)),
      ),
    ),
  );

  //botao para demostrar interesse no animal
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
      onPressed: () {},
    ),
  );
}
