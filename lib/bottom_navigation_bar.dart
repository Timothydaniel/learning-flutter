import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.login, size: 30, color: Colors.black),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gps_fixed, size: 30, color: Colors.black),
          label: 'GPS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit, size: 30, color: Colors.black),
          label: 'Edit',
        ),
      ],
    );
  }
}