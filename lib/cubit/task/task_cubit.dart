// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/service/task_service.dart';
// import 'task_state.dart';

// class TaskCubit extends Cubit<TaskState> {
//   final TaskService _taskPanelService;

//   TaskCubit(this._taskPanelService) : super(TeskInitial());

//   // ignore: duplicate_ignore
//   Future<void> AddTask(
//       {required String Titlle,

//       required String SubTile,

//       required String Description,
//       required String Date,
//       required String Time,
//       required String tag,
//       required String Status}) async {
//     emit(TaskStarted() as TaskState);
//     try {
//       String taskCreated = await _taskPanelService.AddTask(
//         Titlle: Titlle,
//         SubTile: SubTile,
//         Description: Description,
//         Date: Date,
//         Time: Time,
//         tag: tag,
//         Status: Status,
//       );
//       if (taskCreated == 'task_created') {
//         emit(TaskCreateSuccess());
//       } else {
//         emit(TaskFailCreate());
//       }
//     } catch (_) {
//       emit(TaskFailCreate());
//     }
//   }
// }

// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks/cubit/task/task_state.dart';

import '../../data/data/task_list.dart';
import '../../data/service/task_service.dart';

// part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskService;

  TaskCubit(this._taskService) : super(TaskInitial());
}
