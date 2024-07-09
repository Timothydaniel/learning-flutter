import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/crud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/crud',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/crud': (context) => const CrudApp(),
      },
    );
  }
}
