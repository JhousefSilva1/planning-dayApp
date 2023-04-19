import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/service/task_service.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskPanelService;

  TaskCubit(this._taskPanelService) : super(TeskInitial());

  Future<void> AddTask(
      {required String Titlle,
      required String SubTile,
      required String Description,
      required String Date,
      required String Time,
      required String tag,
      required String Status}) async {
    emit(TaskStarted() as TaskState);
    try {
      String taskCreated = await _taskPanelService.AddTask(
        Titlle: Titlle,
        SubTile: SubTile,
        Description: Description,
        Date: Date,
        Time: Time,
        tag: tag,
        Status: Status,
      );
      if (taskCreated == 'task_created') {
        emit(TaskCreateSuccess());
      } else {
        emit(TaskFailCreate());
      }
    } catch (_) {
      emit(TaskFailCreate());
    }
  }
}
