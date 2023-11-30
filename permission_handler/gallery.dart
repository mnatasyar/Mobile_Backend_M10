import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({Key? key}) : super(key: key);

  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  late List<File> imageFiles = [];

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  Future<void> getPhotos() async {
    Directory directory = Directory('/storage/emulated/0/Download');
    List<FileSystemEntity> _imageFiles = directory.listSync(recursive: true);
    setState(() {
      imageFiles = _imageFiles.whereType<File>().toList();
    });
    print('Photos Directory Path: ${directory.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Gallery")),
      body: imageFiles.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: imageFiles.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: Image.file(imageFiles[index], fit: BoxFit.cover),
                );
              },
            )
          : Center(child: Text('No Photos Found')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickImageFromGallery();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFiles.add(File(image.path));
      });
    }
  }
}
