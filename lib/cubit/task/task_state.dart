// import 'package:intl/message_format.dart';

// import '../../data/data/task_list.dart';

// abstract class TaskState {}

// class TeskInitial extends TaskState {}

// class TaskCreateSuccess extends TaskState {}

// class TaskView extends TaskState {}

// class TaskFailCreate extends TaskState {}

// class TaskLoading extends TaskState {}

// class TaskLoaded extends TaskState {
//   final List<Task> tasks;

//   TaskLoaded(this.tasks);
// }

// class TaskError extends TaskState {}

// abstract class TaskEvent {}

// class TaskStarted extends TaskEvent {}

// class TaskAdd extends TaskEvent {}

// class TaskEdit extends TaskEvent {}

// class TaskDelete extends TaskEvent {}

// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

part of 'task_cubit.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final bool isLoading;
  final String errorMessage;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [tasks, isLoading, errorMessage];

  TaskState copyWith({
    required List<dynamic> tasks,
    required bool? isLoading,
    required String errorMessage,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory TaskState.initial() {
    return TaskState();
  }
}

class TaskLoadFail extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> taskList;

  TaskLoadSuccess(this.taskList);
}

class TaskInitial extends TaskState {}
