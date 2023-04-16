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

  void resetPassword(String email) async {
    // Aquí debes llamar al servicio correspondiente para realizar el reseteo de
    // la contraseña. Si el reseteo es exitoso, actualiza el estado con
    // LoginSuccess. Si falla, actualiza el estado con LoginFailure y agrega el
    // mensaje de error correspondiente.
  }  

  void register(String email, String password) async {
    emit(LoginLoading());
    // Aquí debes hacer la validación de las credenciales y llamar al servicio
    // correspondiente para realizar el registro de usuario. Si el registro es
    // exitoso, actualiza el estado con LoginSuccess. Si falla, actualiza el
    // estado con LoginFailure y agrega el mensaje de error correspondiente.
  }

  void updatePassword(String password) async {
    // Aquí debes llamar al servicio correspondiente para actualizar la
    // contraseña del usuario. Si la actualización es exitosa, actualiza el
    // estado con LoginSuccess. Si falla, actualiza el estado con LoginFailure y
    // agrega el mensaje de error correspondiente.
  }

  
}
