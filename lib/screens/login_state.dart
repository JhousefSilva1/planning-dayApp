import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'home_task_screen.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'LoginFailure { errorMessage: $errorMessage }';
}
