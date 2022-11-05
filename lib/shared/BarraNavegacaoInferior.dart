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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Lista de animais',
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil'
        ),
      ],
      backgroundColor: Colors.orangeAccent,
      selectedItemColor: Colors.white,
      unselectedLabelStyle:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      onTap: _onItemTapped,

    );
  }
}