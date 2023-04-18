// ignore: unused_import
import 'package:equatable/equatable.dart';

abstract class TaskPanelState {}

class TeskPanelInitial extends TaskPanelState{}

class TaskPanelCreateSuccess extends TaskPanelState {}

class TaskPanelView extends TaskPanelState {}

class TaskPanelFailCreate extends TaskPanelState {}

abstract class TaskPanelEvent {}

class TaskPanelStarted extends TaskPanelEvent {}

class TaskPanelAdd extends TaskPanelEvent {}

class TaskPanelEdit extends TaskPanelEvent {}

class TaskPanelDelete extends TaskPanelEvent {}
