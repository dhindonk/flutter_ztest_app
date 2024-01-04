import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  const ImagePickers({super.key});

  @override
  State<ImagePickers> createState() => _ImagePickersState();
}

class _ImagePickersState extends State<ImagePickers> {
  late XFile images;

  void imgFromCamera() async {
    XFile? pickedImg = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      images = XFile(pickedImg!.path);
      print('INI PATH NYA : ${images.path}');
    });
  }

  void imgFromGallery() async {
    XFile? pickedImg = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    setState(() {
      images = XFile(pickedImg!.path);
      print('INI DARI GALLERY : ${images.path}');
    });
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: 150,
              child: Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                    child: Text('Camera'),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    },
                    child: Text('Galery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showPicker(context),
          child: Text('Press'),
        ),
      ),
    );
  }
}
