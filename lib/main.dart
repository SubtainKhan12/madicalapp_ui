import 'package:flutter/material.dart';
import 'package:madicalapp_ui/Fingerprint_AUTH/fingerprintPage.dart';
import 'package:madicalapp_ui/Pages/first_page.dart';
import 'package:madicalapp_ui/apiInSQF/complainListScreen.dart';

import 'SQFLite/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FingerprintScreen(),
    );
  }
}
