import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class ImagemService {
  String toBase64(File imagem) {
    final bytes = imagem.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  Image toImage(String base64) {
    return Image.memory(const Base64Decoder().convert(base64));
  }
}
