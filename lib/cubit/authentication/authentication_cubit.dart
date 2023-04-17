import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/authentication_service.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationCubit(this._authenticationService)
      : super(AuthenticationInitial());

  //AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> logIn(
      {required String username, required String password}) async {
    emit(AuthenticationStarted() as AuthenticationState);
    try {
      String authenticated = await _authenticationService.logIn(
        username: username,
        password: password,
      );
      if (authenticated == 'authenticated') {
        emit(AuthenticationSuccess());

        AlertDialog(
          title: const Text('Login Successful'),
          content: const Text('You have successfully logged in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context as BuildContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      } else {
        emit(AuthenticationFailure());
      }
    } catch (_) {
      emit(AuthenticationFailure());
    }
  }
}
