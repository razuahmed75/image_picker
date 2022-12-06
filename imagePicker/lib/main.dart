// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController? _controller;
  String? image;
  Future _imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image!.path;
    });
  }

  Future imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      this.image = image!.path;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => DraggableScrollableSheet(
        snap: true,
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, _controller) => ListView(
          controller: _controller,
          children: [
            Icon(Icons.remove),
            ListTile(
              onTap: () {
                _imagePicker();
              },
              leading: Icon(Icons.collections),
              title: Text("Open Gallery"),
            ),
            ListTile(
              onTap: () {
                imagePicker();
              },
              leading: Icon(Icons.camera),
              title: Text("Open Camera"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text("Flutter theme"),
      ),
      body: Center(
        child: Column(
          children: [
            image != null
                ? ClipOval(
                    child: Image.file(
                      File("$image"),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  )
                : FlutterLogo(size: 150),
            ElevatedButton(
              onPressed: () async {
                _showBottomSheet();
              },
              child: Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
