import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';

import 'package:pedigree_seller/app/components/custom_drop_down_button_widget.dart';

import '../../../constants.dart';
import 'package:image_picker/image_picker.dart';

class DogColors {
  String title;
  int amount;
  DogColors(
    this.title,
    this.amount,
  );
}

List<DogColors> dogColorList = [
  DogColors('Branco', 0),
  DogColors('Preto', 0),
  DogColors('Pardo', 0),
  DogColors('Pintado', 0),
  DogColors('Caramelo', 0),
];

class DogPick {
  File? file;
  final String title;

  DogPick(
    this.title, {
    this.file,
  });
}

List<DogPick> dogPickList = [
  DogPick('Pai'),
  DogPick('Mae'),
];

//FOTO dos pais
//TODO: Cores disponiveis

class StorePetParentsRegistration extends StatefulWidget {
  @override
  _StorePetParentsRegistrationState createState() =>
      _StorePetParentsRegistrationState();
}

class _StorePetParentsRegistrationState
    extends State<StorePetParentsRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cores',
          style: kTitleTextStyle,
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.pop(context),
          );
        }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CustomCheckBoxListWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomFormWidget(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomButtonWidget(
                title: 'Avançar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StorePetParentsRegistration(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFormWidget extends StatefulWidget {
  @override
  _CustomFormWidgetState createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  late final File _image;

  final picker = ImagePicker();

  Future getImage(DogPick dPick) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        dPick.file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: dogPickList
                .map((dogPick) => ListTile(
                      title: Text(dogPick.title),
                      leading: Icon(
                        Icons.upload_rounded,
                      ),
                      trailing: dogPick.file == null
                          ? Text('No image selected.')
                          : Image.file(dogPick.file!),
                      onTap: () {
                        getImage(dogPick);
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class CustomCheckBoxListWidget extends StatefulWidget {
  @override
  _CustomCheckBoxListWidgetState createState() =>
      _CustomCheckBoxListWidgetState();
}

class _CustomCheckBoxListWidgetState extends State<CustomCheckBoxListWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: dogColorList
                .map(
                  (dogColor) => ListTile(
                    title: Text(dogColor.title),
                    leading: Text('${dogColor.amount}'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (dogColor.amount > 0)
                                setState(() {
                                  dogColor.amount--;
                                });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                dogColor.amount++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
