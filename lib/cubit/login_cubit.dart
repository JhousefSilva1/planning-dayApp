import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/login_state.dart';

//part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required loginRepository}) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    // Aquí debes hacer la validación de las credenciales y llamar al servicio
    // correspondiente para realizar el inicio de sesión. Si el inicio de sesión
    // es exitoso, actualiza el estado con LoginSuccess. Si falla, actualiza el
    // estado con LoginFailure y agrega el mensaje de error correspondiente.
  }

  void logout() {
    // Aquí debes eliminar las credenciales del usuario y volver al estado inicial
    emit(LoginInitial());
  }
}
