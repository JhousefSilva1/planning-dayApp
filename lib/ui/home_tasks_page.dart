// ignore_for_file: no_logic_in_create_state, prefer_const_constructors

import 'package:flutter/material.dart';


class HomeTasksPage extends StatefulWidget {
  const HomeTasksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Tasks Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
