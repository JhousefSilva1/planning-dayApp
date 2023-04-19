// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/service/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authenticationService;

  AuthCubit(this._authenticationService) : super(AuthInitial());

  //AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> logIn(
      {required String username, required String password}) async {
    emit(AuthStarted() as AuthState);
    try {
      String authenticated = await _authenticationService.logIn(
        username: username,
        password: password,
      );
      if (authenticated == 'authenticated') {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure());
      }
    } catch (_) {
      emit(AuthFailure());
    }
  }
}
