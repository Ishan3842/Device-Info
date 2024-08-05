import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatefulWidget {
  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String _deviceIdentifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String deviceIdentifier;
    try {
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        deviceIdentifier = androidInfo.display;
        print(deviceIdentifier);
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        deviceIdentifier = iosInfo.identifierForVendor ?? 'Unknown';
        print(deviceIdentifier);
      } else {
        deviceIdentifier = 'Unsupported Platform';
      }
    } catch (e) {
      deviceIdentifier = 'Failed to get platform version';
    }

    if (!mounted) return;

    setState(() {
      _deviceIdentifier = deviceIdentifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info'),
      ),
      body: Center(
        child: Text(
          'Device Identifier: $_deviceIdentifier',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
