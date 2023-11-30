import 'package:flutter/material.dart';
import 'package:flutter_firebase_backend/permission_handler/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'contact.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Position? _currentPosition;
  int deniedCount = 0;

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
          ],
        ),
      ),
    );
  }

  void contact() async {
    final status = await Permission.contacts.request();

    if (status.isGranted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactScreen()));
    } else if (status.isDenied) {
      deniedCount++;
      if (deniedCount >= 3) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Go to Settings'),
            content: Text('Please go to settings to enable contact permission.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  deniedCount = 0;
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Permission Required'),
            content: Text('Please grant contact permission to proceed.'),
            actions: <Widget>[
              TextButton(
                child: Text('Deny'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Allow'),
                onPressed: () {
                  deniedCount = 0;
                  contact();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  void camera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScreen()));
    } else if (status.isDenied) {
      deniedCount++;
      if (deniedCount >= 3) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Go to Settings'),
            content: Text('Please go to settings to enable camera permission.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  deniedCount = 0;
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Permission Required'),
            content: Text('Please grant camera permission to proceed.'),
            actions: <Widget>[
              TextButton(
                child: Text('Deny'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Allow'),
                onPressed: () {
                  deniedCount = 0;
                  camera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }
}
