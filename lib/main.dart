import 'package:flutter/material.dart';
import 'package:tasks/screen/login/login_screen.dart';
import 'package:tasks/screen/tags/tag_screen.dart';
import 'package:tasks/screen/task/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/task_panel': (context) => TaskPanel(),
        '/tags_panel': (context) => TagsPanel(),
      },
    );
  }
}
