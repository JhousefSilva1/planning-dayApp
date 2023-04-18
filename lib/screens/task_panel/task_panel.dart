import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/data/services/task_panel_service.dart';

import '../../cubit/tasks/task_panel_cubit.dart';
import '../../cubit/tasks/task_panel_state.dart';

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
        create: (_) => TaskPanelCubit(TaskPanelService()),
        child: BlocBuilder<TaskPanelCubit, TaskPanelState>(
          builder: (context, state) {
            return Material(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
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
