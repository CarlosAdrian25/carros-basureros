// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoreo de Carros Basureros',
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
