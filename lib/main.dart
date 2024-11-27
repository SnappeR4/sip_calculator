import 'package:flutter/material.dart';
import 'package:sip/views/sip_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIP Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SIPScreen(),
    );
  }
}
