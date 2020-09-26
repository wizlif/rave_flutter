import 'package:flutter/material.dart';
import 'package:rave_flutter/rave_flutter.dart';

void main() {
  runApp(MyApp(),);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Plugin Ex.'),
        ),
        body: Center(
          child: UgandaMobileMoneyPay(
            "FLWSECK_TEST-SANDBOXDEMOKEY-X",
            5000,
            "user@gmail.com",
            "FLW-23456",
            fullName: "Yemi Desola",
            businessName: "wizlif studios",
          ),
        ),
      ),
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
    );
  }
}
