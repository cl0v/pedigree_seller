import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//TODO: Implementar o imagePicker onde precisa enviar fotos

class ImagePickerTileWidget extends StatelessWidget {
  final String title;
  final File? file;
  final ValueChanged<File?>? onChanged;
  const ImagePickerTileWidget({
    Key? key,
    required this.title,
    this.file,
    this.onChanged,
  }) : super(key: key);

  _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) return onChanged?.call(File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        Icons.upload_rounded,
      ),
      trailing:
          file != null ? Image.file(file!) : Text('Toque para enviar foto'),
      onTap: _getImage,
    );
  }
}
