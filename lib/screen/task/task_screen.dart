// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/data/data/task_list.dart';

import '../../cubit/task/task_cubit.dart';
import '../../data/service/task_service.dart';

// Importamos el Cubit que maneja el estado de las tareas.

class TaskPanel extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TaskPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TaskCubit(TaskService()),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF004070),
                title: const Text(
                  'Tareas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: const [
                    //Floating button a pir de pantalla
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showAboutDialog(context: context);
                },
                backgroundColor: const Color(0xFF004070),
                child: const Icon(Icons.add),
              ),
            );
          },
        ));
  }
}
