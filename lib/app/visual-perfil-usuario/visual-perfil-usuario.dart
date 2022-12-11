import 'package:adote_um_amigo/shared/db_service.dart';
import 'package:flutter/material.dart';
import 'package:adote_um_amigo/models/usuario.dart';
import 'package:adote_um_amigo/shared/imagem_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/rotas.dart';
import '../../shared/style.dart';

class VisualPerfilUsuario extends StatefulWidget {
  final int donoId;
  const VisualPerfilUsuario(this.donoId, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _VisualPerfilState();
}

class _VisualPerfilState extends State<VisualPerfilUsuario> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  Usuario user = Usuario.empty();

  @override
  initState() {
    super.initState();

    DataBaseService().getUserById(widget.donoId).then((value) {
      user = value;
      setState(() {});
    });
  }

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
        backgroundImage: user.imagemPerfil.isEmpty
            ? Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')
                .image
            : ImagemService().toImage(user.imagemPerfil).image,
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            user.nome,
            style: const TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(left: 32, right: 32),
            child: Text(
              user.apresentacao,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Contatos',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Telefone',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              user.telefone,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'E-mail',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              user.email,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
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
                  'Voltar',
                  style: TextStyle(fontSize: 16),
                ),
                // Botão que abre uma segunda tela mostrando o perfil do usuário
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, Rotas.chat);
                  // redirecionar para a rota do chat com o tutor do animal
                },
              ),
            ),
          )
        ],
      );
}
