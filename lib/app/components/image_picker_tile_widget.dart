import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:path/path.dart' as p;
//  nome: p.extension(result.files.single.name),

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
  final ValueChanged<Foto> onChanged;
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

  _getImage() async {
    //TODO: Modificar isso e enviar o arquivo direto
    //Melhor do que criar um objeto so pra trabalhar com isso(Foto)
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        Foto foto = Foto(
          nome: result.files.single.name,
          fileUnit: result.files.first.bytes,
          path: result.files.first.path,
        );
        setState(() {
          widget.onChanged.call(foto);
          _picked = true;
        });
      } else
        print('Nenhuma foto selecionada');
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
