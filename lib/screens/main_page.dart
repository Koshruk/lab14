import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lab14/services/native.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  File? _image;

  Future<void> takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            OutlinedButton(
                onPressed: () async {
                  String nativeData = await fetchData();
                  if (!mounted) return;
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: const Text(
                            'Native data:',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                              nativeData,
                            style: TextStyle(
                              fontSize: 30
                            ),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text(
                                'Ok',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      }
                  );
                },
                child: const Text(
                  'Get data',
                ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            _image != null
                ? Image.file(_image!)
                : const Placeholder(
                  color: Colors.transparent,
                  fallbackHeight: 200,
                  fallbackWidth: double.infinity,
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo_rounded),
        onPressed: takePicture,
      ),
    );
  }
}