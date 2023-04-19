abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {}

class AuthServerFailure extends AuthState implements Exception {}

class AuthTokenExpire extends AuthState implements Exception {}

abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}
