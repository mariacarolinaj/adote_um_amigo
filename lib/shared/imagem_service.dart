import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagemService {
  String toBase64(PickedFile foto) {
    File imagem = File(foto.path);
    final bytes = imagem.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  Image toImage(String base64) {
    return Image.memory(const Base64Decoder().convert(base64),
        gaplessPlayback: true);
  }
}
