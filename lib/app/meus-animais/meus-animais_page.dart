import 'package:flutter/material.dart';

import '../../shared/rotas.dart';

class MeusAnimaisPage extends StatelessWidget {
  final String title;

  const MeusAnimaisPage({Key? key, this.title = 'MeusAnimaisPage'})
      : super(key: key);

  @override
  MeusAnimaisPageStateless createState() => MeusAnimaisPageStateless();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            child: Text(
              'Meus animais',
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pushNamed(context, Rotas.perfilUsuario)
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: MeusAnimaisPageStateless(),
    );

  }
}

class MeusAnimaisPageStateless extends StatelessWidget{
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/08/12/16/59/parrot-3601194_960_720.jpg'),
          ),
          title: Text(
              'Lupi',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'Localizado em BH, é uma Arara-canindé.',
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Divider(),

        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_960_720.jpg'),
          ),
          title: Text(
            'Balu',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Localizado em BH, é um gato da raça Angorá turco',
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Divider(),

        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2017/12/10/15/16/white-horse-3010129_960_720.jpg'),
          ),
          title: Text(
              'Thor',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Localizado em SP, é um cavalo da raça Mangalarga',
          style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Divider(),

        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_960_720.jpg'),
          ),
          title: Text(
            'Balu',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Localizado em BH, é um gato da raça Angorá turco',
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Divider(),

        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_960_720.jpg'),
          ),
          title: Text(
            'Balu',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Localizado em BH, é um gato da raça Angorá turco',
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Divider(),

        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_960_720.jpg'),
          ),
          title: Text(
            'Balu',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Localizado em BH, é um gato da raça Angorá turco',
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),

      ],
    );
  }
}