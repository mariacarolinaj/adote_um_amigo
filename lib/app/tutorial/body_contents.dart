import 'package:flutter/material.dart';

Widget bodyContents(String imgUrl, String title, String description) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imgUrl),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 18,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      )
  );
}
