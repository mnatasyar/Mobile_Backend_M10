import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_backend/permission_handler/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'contact.dart';
import 'gallery.dart';
import 'storage.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Color _backgroundColor = Colors.white;
  Timer? _timer;
  bool _isColorChanging = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: contact, child: Text("Contant")),
            ElevatedButton(onPressed: camera, child: Text("Camera")),
            ElevatedButton(onPressed: storage, child: Text("Storage")),
            // ElevatedButton(onPressed: _changeBackgroundColor, child: Text("Jangan Ditekan!!!")),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => PhotoGalleryScreen(),
            //       ),
            //     );
            //   },
            //   child: Text('Open Photo Gallery'),
            // ),
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
    );
  }
  void contact() async {
    if (await Permission.contacts.status.isGranted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ContactScreen()));
    } else {
      var status = await Permission.contacts.request();
      print(status);
      if (status == PermissionStatus.granted) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
    }
    }
  }
  void camera() async {
    if (await Permission.camera.status.isGranted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    } else {
      var status = await Permission.camera.request();
      print(status);
      if (status == PermissionStatus.granted) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CameraScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }
  void storage() async {
    if (await Permission.storage.status.isGranted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => StorageScreen()));
    } else {
      var status = await Permission.storage.request();
      print(status);
      if (status == PermissionStatus.granted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => StorageScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void _changeBackgroundColor() {
    if (_isColorChanging) {
      _timer?.cancel();
      setState(() {
        _backgroundColor = Colors.white;
        _isColorChanging = false;
      });
    } else {
      _isColorChanging = true;
      _timer = Timer.periodic(Duration(milliseconds: 250), (timer) {
        setState(() {
          _backgroundColor = _randomColor();
        });
      });
    }
  }

  Color _randomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}