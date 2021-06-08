import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

/// The stateful widget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// The class with the scaffold
class _MyAppState extends State<MyApp> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      File rotatedImage =
          await FlutterExifRotation.rotateImage(path: image.path, outputFormat: OutputFormat.PNG);
      setState(() {
        _image = rotatedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exif flutter rotation image example app'),
        ),
        body: new Center(
          child: _image == null
              ? new Text('No image selected.')
              : new Image.file(_image!),
        ),
        persistentFooterButtons: <Widget>[
          new FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image without saving',
            child: new Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
