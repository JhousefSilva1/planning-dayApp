abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {}

class AuthServerFailure extends AuthState {}

class AuthInternetFailure extends AuthState {}

class AuthCredentialsFailure extends AuthState {}

class AuthTokenExpire extends AuthState {}

abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}
