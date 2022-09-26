import 'package:flutter/material.dart';

class BarraNavegacaoInferior extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Conversas',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Meus Interesses'
        ),
      ],
      backgroundColor: Colors.orangeAccent,
      selectedItemColor: Colors.white,
      unselectedLabelStyle:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

    );
  }
}