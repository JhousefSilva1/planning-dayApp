import 'package:tasks/api/api_client.dart';
import '../api/api_client.dart';

class LoginRepository {
  final ApiClient apiClient;

  LoginRepository({required this.apiClient});

  Future<bool> login(String username, String password) async {
    final response = await apiClient
        .post('login', {'username': username, 'password': password});
    // Aquí se podría agregar lógica adicional para procesar la respuesta de la API

    return response['success'] == true;
  }
}
