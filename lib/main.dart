import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phoneselectorhint/phoneselectorhint.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String platformVersion = 'Unknown';
  String hint = '';
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await Phoneselectorhint.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
      hint = hint;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Phone Selector Hint'),
          actions: const [],
        ),
        persistentFooterButtons: const [
          Text(
            "Done by Gobal Krishnan V, Flutter Developer & Engineer",
            style: TextStyle(fontSize: 8),
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Note: Click on the Hint button to pick mobile number"),
            Center(
              child: Text(
                'Mobile : $hint\n',
                style: const TextStyle(fontSize: 23),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (Platform.isAndroid) {
              try {
                hint = await Phoneselectorhint.hint ?? '';
                setState(() {
                  hint = hint;
                });
                print("phne - $hint");
              } on PlatformException {
                hint = 'phone number is not working';
              }
            } else {}
          },
          child: const Text("Hint"),
        ),
      ),
    );
  }
}
