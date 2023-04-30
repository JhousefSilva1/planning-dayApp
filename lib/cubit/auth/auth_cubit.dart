// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/app/constants.dart';

import '../../data/service/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authenticationService;

  AuthCubit(this._authenticationService) : super(AuthInitial());

  //AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> logIn({required String username, required String password}) async {
    // emit(AuthStarted() as AuthState);
    emit(AuthInitial());
    try {
      String authenticated = await _authenticationService.logIn(
        username: username,
        password: password,
      );
      if (authenticated == '0000') {
        emit(AuthSuccess());
      } else if (authenticated == '0001') {
        emit(AuthCredentialsFailure());
      } else if (authenticated == Globals.checkInternet) {
        emit(AuthInternetFailure());
      } else if(authenticated == Globals.checkServer){
        emit(AuthServerFailure());
      }
    } catch (_) {
      emit(AuthFailure());
    }
  }
}
