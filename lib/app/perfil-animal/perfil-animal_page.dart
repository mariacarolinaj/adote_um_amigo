import 'dart:io';

import 'package:adote_um_amigo/models/animal.dart';
import 'package:flutter/material.dart';

class PerfilAnimalPage extends StatefulWidget {
  final String title;
  final Animal? animal;

  const PerfilAnimalPage(Map<Animal, Animal> map, {this.animal, Key? key, this.title = 'PerfilAnimalPage'})
      : super(key: key);
  @override
  PerfilAnimalPageState createState() => PerfilAnimalPageState();
}

class PerfilAnimalPageState extends State<PerfilAnimalPage> {
  @override
  Widget build(BuildContext context) {
                  print(widget.animal);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
