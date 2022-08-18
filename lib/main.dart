import 'package:flutter/material.dart';
import 'package:smart_auth/smart_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final smartAuth = SmartAuth();
  final pinputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAppSignature();
    requestHint();
  }

  @override
  void dispose() {
    smartAuth.removeSmsListener();
    pinputController.dispose();
    super.dispose();
  }

  void getAppSignature() async {
    final res = await smartAuth.getAppSignature();
    debugPrint('Signature: $res');
  }

  void requestHint() async {
    final res = await smartAuth.requestHint(
      isPhoneNumberIdentifierSupported: true,
      // isEmailAddressIdentifierSupported: true,
      showCancelButton: true,
    );
    debugPrint('requestHint: $res');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: requestHint, child: const Text('Request Hint')),
          ],
        ),
      ),
    );
  }
}
