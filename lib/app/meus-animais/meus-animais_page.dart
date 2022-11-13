import 'package:flutter/material.dart';

import '../../models/animal.dart';
import '../../models/tipo-animal-enum.dart';
import '../../shared/db_service.dart';
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
        title: Text(
          'Meus animais',
          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
  List<Animal> myanimals = [];

  //dados para teste
  Animal an = Animal(02, "baluu", "pit", "manso", "em dia", 1, [], 01, TipoAnimal.Cachorro);
  Animal an2 = Animal(02, "bob", "pit", "manso", "em dia", 1, [], 01, TipoAnimal.Cachorro);


  @override
  Widget build(BuildContext context) {

    myanimals.add(an);
    myanimals.add(an2);
    // DataBaseService()..getAnimalByUserId(1).then((value) => myanimals = value);
    DataBaseService().getAllAnimal().then((value) => myanimals = value);


    return Container(
          child: myanimals.length > 0
              ? Column(
            children: myanimals.map((e) =>
                _buildAnimalsGrid(e),
            ).toList(),
          )
              : Container(
            padding: EdgeInsets.all(16),
            child: const Text(
                'Não existem pets em sua lista'),
          ));
    }

  Widget _buildAnimalsGrid(Animal animal) {
    // var localizacao pegar o usuario a partir do animal
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/08/12/16/59/parrot-3601194_960_720.jpg'),
          ),
          title: Text(
              animal.nome,
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'Localizado em BH',
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Divider(),
      ],
    );
  }
}