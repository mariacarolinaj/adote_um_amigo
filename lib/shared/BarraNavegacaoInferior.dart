import 'dart:developer';

import 'package:adote_um_amigo/app/listagem-animais/listagem-animais_page.dart';
import 'package:adote_um_amigo/app/meus-animais/meus-animais_page.dart';
import 'package:adote_um_amigo/app/perfil-usuario/perfil-usuario_page.dart';
import 'package:flutter/material.dart';

class BarraNavegacaoInferior extends StatefulWidget {
  final String title;
  const BarraNavegacaoInferior({Key? key, this.title = 'BarraDeNavegação'})
      : super(key: key);
  @override
  BarraNavegacaoInferiorState createState() => BarraNavegacaoInferiorState();
}

class BarraNavegacaoInferiorState extends State<BarraNavegacaoInferior> {
  int _selectedIndex = 0;
  final List<Widget> _telas = [
    const ListagemAnimaisPage(),
    const MeusAnimaisPage(),
    const PerfilUsuarioPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('movieTitle: $ind');
    return Scaffold(
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Meus animais',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        backgroundColor: Colors.orangeAccent,
        selectedItemColor: Colors.white,
        unselectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
