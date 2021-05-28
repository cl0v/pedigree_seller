import 'dart:typed_data';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//TODO: Implementar o imagePicker onde precisa enviar fotos

class Foto {
  String nome;
  Uint8List? fileUnit;
  String? path;

  Foto({
    required this.nome,
    this.fileUnit,
    this.path,
  });
}

class ImagePickerTileWidget extends StatefulWidget {
  final String title;
  final Function(Foto) onChanged;
  const ImagePickerTileWidget({
    Key? key,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ImagePickerTileWidgetState createState() => _ImagePickerTileWidgetState();
}

class _ImagePickerTileWidgetState extends State<ImagePickerTileWidget> {
  bool _picked = false;
  //TODO: Testar com o android

  _getImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        // var fileName = result.files.single.name;
        // Uint8List? fileBytes = result.files.first.bytes;
        // print(result);
        // print(result.files);
        // print(result.files.first);
        // print(result.files.first.path);

        Foto foto = Foto(
            nome: result.files.single.name,
            fileUnit: result.files.first.bytes,
            path: result.files.first.path);

        setState(() {
          widget.onChanged.call(foto);
          _picked = true;
        });
      } else
        print('result ta nulo');
    } catch (e) {
      print('Ocorreu um error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: Icon(
        Icons.upload_rounded,
      ),
      trailing:
          _picked ? Text('Foto escolhida') : Text('Toque para enviar foto'),
      onTap: _getImage,
    );
  }
}
