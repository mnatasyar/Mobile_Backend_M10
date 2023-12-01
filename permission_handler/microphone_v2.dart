import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MicrophoneScreen extends StatefulWidget {
  const MicrophoneScreen({Key? key}) : super(key: key);

  @override
  _MicrophoneScreenState createState() => _MicrophoneScreenState();
}

class _MicrophoneScreenState extends State<MicrophoneScreen> {
  bool isMicrophoneAllowed = false;

  @override
  void initState() {
    super.initState();
    checkMicrophonePermission();
  }

  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    setState(() {
      isMicrophoneAllowed = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Microphone"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mic,
              size: 100,
              color: isMicrophoneAllowed ? Colors.green : Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              isMicrophoneAllowed
                  ? "Microphone access granted!"
                  : "Microphone access denied.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: simulateMicrophoneFunctionality,
              child: Text("Simulate Microphone"),
            ),
          ],
        ),
      ),
    );
  }

  void simulateMicrophoneFunctionality() async {
    if (await Permission.microphone.status.isGranted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MicrophoneScreen()));
    } else {
      var status = await Permission.microphone.request();
      print(status);
      if (status == PermissionStatus.granted) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MicrophoneScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
    print("Simulating microphone functionality...");
  }
}
