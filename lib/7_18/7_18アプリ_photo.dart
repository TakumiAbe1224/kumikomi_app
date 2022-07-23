import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class  PhotoPage extends StatefulWidget {
  const PhotoPage({Key ?key}) : super(key: key);

  @override
  _RegisterProfileState createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State {
  var _image;
  final _picker = ImagePicker();

  Future getImageFromCamera() async {
    final _pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (_pickedFile != null){
        _image = File(_pickedFile.path);
      }
    });
  }

  Future getImageFromGallery() async {
    final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(_pickedFile != null){
        _image = File(_pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('写真選択'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: getImageFromCamera,
                  tooltip: 'Pick Image From Camera',
                  child: Icon(Icons.add_a_photo),
                ),
                FloatingActionButton(
                  onPressed: getImageFromGallery,
                  tooltip: 'Pick Image From Gallery',
                  child: Icon(Icons.photo_library),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}