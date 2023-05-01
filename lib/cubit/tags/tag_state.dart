import 'package:tasks/data/models/tags.dart';
import 'package:tasks/data/models/tasks.dart';

abstract class TagsState {}

class TagsInitial extends TagsState {
  List get props => [];
}

class TagsInternetFailure extends TagsState {}

class TagsServerFailure extends TagsState {}

class TagsSuccess extends TagsState {
  TagsSuccess(this.tags);

  late final List<Tags> tags;

  @override
  List get props => [tags];
}

abstract class TaskEvent {}

class TagsStarted extends TaskEvent {}

class TagsCreateSuccess extends TagsState {}

class TagsFail extends TagsState {}
