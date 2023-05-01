

import 'package:tasks/data/models/tags.dart';
import 'package:tasks/data/models/tasks.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {
  List get props => [];
}

class TaskInternetFailure extends TaskState {}

class TaskServerFailure extends TaskState {}

class TaskSuccess extends TaskState {
  TaskSuccess(this.task, this.tags);

  late final List<Task> task;
  late final List<Tags> tags;

  @override
  List get props => [task, tags];
}

abstract class TaskEvent {}

class TaskStarted extends TaskEvent {}

class TaskCreateSuccess extends TaskState {}

class TaskFail extends TaskState {}
