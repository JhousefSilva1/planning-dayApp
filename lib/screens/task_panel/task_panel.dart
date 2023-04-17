// crear pantalla basica

import 'package:flutter/material.dart';

class TaskPanel extends StatelessWidget {
  const TaskPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Panel'),
      ),
      body: const Center(
        child: Text('Task Panel'),
      ),
    );
  }
}
