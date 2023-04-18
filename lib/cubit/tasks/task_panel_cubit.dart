// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'task_panel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/task_panel_service.dart';

class TaskPanelCubit extends Cubit<TaskPanelState> {
  final TaskPanelService _taskPanelService;

  TaskPanelCubit(this._taskPanelService) : super(TeskPanelInitial());

  // ignore: non_constant_identifier_names
  Future<void> AddTask(
      {required String Titlle,
      required String SubTile,
      required String Description,
      required String Date,
      required String Time,
      required String tag,
      required String Status}) async {
    emit(TaskPanelStarted() as TaskPanelState);
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
        emit(TaskPanelCreateSuccess());
      } else {
        emit(TaskPanelFailCreate());
      }
    } catch (_) {
      emit(TaskPanelFailCreate());
    }
  }
}
