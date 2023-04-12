part of 'auth_cubit.dart';

abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String passwordd;

  AuthLoginRequested(this.username, this.passwordd);
}

class AuthLogoutRequested extends AuthEvent {}
