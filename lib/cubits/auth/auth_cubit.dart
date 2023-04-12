import 'package:bloc/bloc.dart';
import 'package:tasks/cubits/auth/auth_cubit.dart';
import 'package:tasks/models/User.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.unauthenticated());

  void login(String username, String passwordd) {
        if (username == 'admin' && passwordd == 'admin') {
      final user = User(username: username, passwordd: passwordd);
     // emit(AuthState.authenticated(user));
      emit(AuthState.Authenticated(User(username: username, passwordd: passwordd)))
    } else {
      emit(AuthState.unauthenticated());
    }
  }

    void logout() {
    emit(AuthState.unauthenticated());
  }
    User? getCurrentUser() {
    final state = state;
    if (state is Authenticated) {
      return state.user;
    } else {
      return null;
    }
  }
}

}
