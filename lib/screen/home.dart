import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:first_task/service/firbase.dart';
import 'package:first_task/widgets/listViewBuilder.dart';

class MyHome extends StatefulWidget{
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  File? _image;
  final picker = ImagePicker();
  List<AssetImage>? listOfImage;
  int _randomNumber = 0;

  void _incrementCounter() {
    setState(() {
      Random random = new Random();
      _randomNumber = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.image, size: 20),
        title: Text("Image picker and upload"),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/checkout'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: LoadData(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: getImage,
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    _incrementCounter();
    FirebaseHandel().uploadFile(_image, _randomNumber);
    }
}