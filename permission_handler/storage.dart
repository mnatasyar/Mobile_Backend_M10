import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  late List<File> files = [];

  @override
  void initState() {
    super.initState();
    getFilesList();
  }

  Future<void> getFilesList() async {
    Directory directory = await getApplicationDocumentsDirectory() ?? Directory('');
    List<FileSystemEntity> _files = directory.listSync(recursive: true);
    setState(() {
      files = _files.whereType<File>().toList();
    });
    print('Directory Path: ${directory.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Storage")),
      body: files.isNotEmpty
          ? ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.file_present),
                  title: Text(files[index].path.split('/').last),
                );
              },
            )
          : Center(child: Text('No Files Found')),
    );
  }
}
