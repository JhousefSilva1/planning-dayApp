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
import 'package:flutter/src/widgets/scroll_view.dart';


import '../../data/data/task_list.dart';
import '../../data/service/task_service.dart';


part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskService;



  TaskCubit(this._taskService, ) : super(TaskState.initial());

  Future<void> fetchTasks() async {


    try {
      emit(state.copyWith(isLoading: true, errorMessage: '', tasks: []));
      final tasks = await _taskService.fetchTasks();
      emit(state.copyWith(tasks: tasks, isLoading: false, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Failed to fetch tasks.', tasks: []));
    }
  }

  Future<void> createTask(String id, String title, String subtitle, String description,
                          DateTime date, bool isDone, String tag) async {
    try {
      final newTask = Task(
        id:id,
        title: title,
        subtitle: subtitle,
        description: description,
        date: DateTime.now(), 
        isDone: false, 
        tag: tag

      );
      final createdTask = await _taskService.createTask(newTask as String);
      final tasks = List.from(state.tasks)..add(createdTask);
      emit(state.copyWith(tasks: tasks, errorMessage: '', isLoading: null,  ));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to create task.', isLoading: false, tasks: []  ));
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await _taskService.updateTask(updatedTask);
      final tasks = state.tasks.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
      emit(state.copyWith(tasks: tasks, isLoading: null, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update task.', isLoading: null, tasks: []));
    }
  }

  Future<void> deleteTask(Task taskToDelete) async {
    try {
      await _taskService.deleteTask(taskToDelete);
      final tasks = state.tasks.where((t) => t.id != taskToDelete.id).toList();
      emit(state.copyWith(tasks: tasks, isLoading: null, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete task.', tasks: [], isLoading: null));
    }
  }

  void addTask(Task task) {}
}

