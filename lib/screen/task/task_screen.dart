import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/task/task_cubit.dart';
import '../../cubit/task/task_state.dart';
import '../../data/service/task_service.dart';

class TaskPanel extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // late String _title = '';
  // late String _subTitle='';
  // late String _description='';
  // late DateTime _date;
  // late String _tag='';
  // late bool isDone;

  //final List<Task> __tasks = [];
  TaskPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TaskCubit(TaskService()),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Material(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.task,
                              size: 100,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
