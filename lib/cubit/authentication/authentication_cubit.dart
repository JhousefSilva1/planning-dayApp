// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:bloc/bloc.dart';


import '../../data/services/authentication_service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState {
  final AuthenticationStatus status;
  final String? error;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.error,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated() : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated({String? error}) : this._(status: AuthenticationStatus.unauthenticated, error: error);
}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService authService;

  AuthenticationCubit({required this.authService}) : super(const AuthenticationState.unknown());

  Future<void> logIn({required String username, required String password}) async {
    try {
      final authToken = await authService.logIn(username: username, password: password);
      emit(const AuthenticationState.authenticated());
      // guarda el token de autenticación en el almacenamiento local
    } catch (e) {
      emit(AuthenticationState.unauthenticated(error: e.toString()));
    }
  }

  void logOut() {
    authService.logOut();
    // borra el token de autenticación del almacenamiento local
    emit(const AuthenticationState.unauthenticated());
  }

  void checkAuthentication() {
    final token = authService.getAuthToken();
    if (token != null) {
      emit(const AuthenticationState.authenticated());
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }
}
