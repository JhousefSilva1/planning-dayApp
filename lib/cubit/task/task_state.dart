import 'package:intl/message_format.dart';

abstract class TaskState {}

class TeskInitial extends TaskState {}

class TaskCreateSuccess extends TaskState {}

class TaskView extends TaskState {}

class TaskFailCreate extends TaskState {}

abstract class TaskEvent {}

class TaskStarted extends TaskEvent {}

class TaskAdd extends TaskEvent {}

class TaskEdit extends TaskEvent {}

class TaskDelete extends TaskEvent {}
