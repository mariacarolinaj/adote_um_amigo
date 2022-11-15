import 'package:adote_um_amigo/shared/imagem_service.dart';
import 'package:flutter/material.dart';

import '../../models/animal.dart';
import '../../models/tipo-animal-enum.dart';
import '../../models/usuario.dart';
import '../../shared/db_service.dart';
import '../../shared/rotas.dart';
import '../../shared/style.dart';
import '../perfil-animal/perfil-animal_page.dart';

class MeusAnimaisPage extends StatefulWidget {
  final String title;

  const MeusAnimaisPage({Key? key, this.title = 'MeusAnimaisPage'})
      : super(key: key);

  @override
  State<MeusAnimaisPage> createState() => _MeusAnimaisPageState();
}

class _MeusAnimaisPageState extends State<MeusAnimaisPage> {
  var _user = Usuario.empty();
  List<Animal> _animais = [];

  @override
  initState() {
    super.initState();
    DataBaseService().getUsuarioLogado().then((result) {
      _user = result;
      DataBaseService().getAnimalByUserId(_user.id).then((value) {
        _animais = value;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
        child: Column(
          children: <Widget>[
            _buildTitleHeader(),
            _buildList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Rotas.cadastroAnimal);
        },
        label: const Text('Cadastrar animal'),
        icon: const Icon(Icons.add),
        backgroundColor: Cores.secondary,
      ),
    );
  }

  Widget _buildTitleHeader() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: 'Meus animais',
          style: TextStyle(
              color: Cores.titulo,
              fontSize: 32,
              fontFamily: 'Jost',
              fontStyle: FontStyle.normal),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      child: _animais.isNotEmpty
          ? Column(
              children: _animais.map((e) => _buildAnimalsGrid(e)).toList(),
            )
          : Container(
              padding: const EdgeInsets.all(16),
              child: const Text('Não existem pets em sua lista'),
            ),
    );
  }

  Widget _buildAnimalsGrid(Animal animal) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: animal.fotos.isEmpty
                ? Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxYfkM0bPSesaofJe0efo9xNzn_-sa2L8RPg&usqp=CAU')
                    .image
                : ImagemService().toImage(animal.fotos.first).image,
          ),
          title: Text(
            animal.nome,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            'Raça ${animal.raca}, possui ${animal.idade} anos de idade',
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return PerfilAnimalPage(animal, true);
              },
            );
          },
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
