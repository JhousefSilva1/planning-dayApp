import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks/cubit/task/task_state.dart';
import 'package:tasks/data/service/tag_service.dart';

import '../../data/models/tasks.dart';
import '../../data/service/task_service.dart';

// part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskService;
  final TagsService _tagsService;

  TaskCubit(this._taskService, this._tagsService) : super(TaskInitial()){
    allTasks();
  }

  Future<void> allTasks() async {
    try {
      // emit(TaskInitial());
    //   emit(state.copyWith(isLoading: true, errorMessage: '', tasks: []));
      final tasks = await _taskService.allTasks();
      final tags = await _tagsService.allTags();
      emit(TaskSuccess(tasks, tags));
    } catch (e) {
      emit(TaskFail());
    }
  }

  Future<void> createTask(Task task) async {
    try {
      // final newTask = Task(
      //   description: 'first task',
      //   date: DateTime.now(),
      //   labelIds: [1,2],
      // );
      final createdTask = await _taskService.createTask(task);
      print(createdTask);
      final tasks = await _taskService.allTasks();
      final tags = await _tagsService.allTags();
      emit(TaskSuccess(tasks, tags));
    //   final tasks = List.from(state.tasks)..add(createdTask);
    //   emit(state.copyWith(
    //     tasks: tasks,
    //     errorMessage: '',
    //     isLoading: null,
    //   ));
    } catch (e) {
      print(e);
    //   emit(state.copyWith(
    //       errorMessage: 'Failed to create task.', isLoading: false, tasks: []));
    }
  }

  Future<void> updateTask(Task? updatedTask, int? id) async {
    try {
      final updateTask = Task(
        description: 'first task',
        date: DateTime.now(),
        labelIds: [1,2],
        isDone: false
      );
      await _taskService.updateTask(updateTask, 3);
    //   final tasks = state.tasks
    //       .map((t) => t.id == updatedTask.id ? updatedTask : t)
    //       .toList();
    //   emit(state.copyWith(tasks: tasks, isLoading: null, errorMessage: ''));
    } catch (e) {
    //   emit(state.copyWith(
    //       errorMessage: 'Failed to update task.', isLoading: null, tasks: []));
    }
  }
}
