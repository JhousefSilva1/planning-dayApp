// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tasks/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      home: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          LoginPage(),
        ],
      ),
    );
  }
}
