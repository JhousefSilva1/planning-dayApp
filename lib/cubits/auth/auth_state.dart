part of 'auth_cubit.dart';

abstract class AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);
}

// ignore: camel_case_types
class unauthenticated extends AuthState {}
