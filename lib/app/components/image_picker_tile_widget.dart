import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//TODO: Fazer o imagePicker pegar imagens;

class ImagePickerTileWidget extends StatelessWidget {
  final String title;
  final File? file;
  // final Function(File) fileSetter;
  const ImagePickerTileWidget({
    Key? key,
    required this.title,
    this.file,
    // required this.fileSetter,
  }) : super(key: key);

  Future<File?> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) return File(pickedFile.path);
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
      onTap: () async {
        // var img = await getImage();
        // if (img != null) fileSetter(img);
      },
    );
  }
}
