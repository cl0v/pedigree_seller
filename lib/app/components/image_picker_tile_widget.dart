import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//TODO: Implementar o imagePicker onde precisa enviar fotos

class ImagePickerTileWidget extends StatefulWidget {
  final String title;
  final ValueChanged<File> onChanged;
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
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _picked = true;
        return widget.onChanged.call(File(pickedFile.path));
      });
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
