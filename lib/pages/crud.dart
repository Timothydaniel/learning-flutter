import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import '../bottom_navigation_bar.dart';
import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CrudApp());
}

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My App', style: TextStyle(color: Colors.white),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
              ),
            ),
          ),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) => _onTapNavigation(context, index),
        ),
      ),
    );
  }

  void _onTapNavigation(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const LoginPage();
        break;
      case 1:
        page = const Home();
        break;
      case 2:
        page = const CrudApp();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
