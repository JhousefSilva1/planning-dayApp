//construye el main
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/cubit/home_task_page_cubit.dart';
import 'package:tasks/repositories/login_repository.dart';
import 'package:tasks/screens/home_task_screen.dart';
import 'package:tasks/screens/login_screen.dart';

import 'api/api_client.dart';
import 'cubit/login_cubit.dart';

void main() {
  final apiClient = ApiClient(); // Instancia del ApiClient
  final loginRepository =
      LoginRepository(apiClient: apiClient); // Instancia del LoginRepository

  runApp(MyApp(loginRepository: loginRepository));
}

class MyApp extends StatelessWidget {
  final LoginRepository loginRepository;

  const MyApp({super.key, required this.loginRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) => LoginCubit(loginRepository: loginRepository),
              child: const LoginScreen(),
            ),
        // Aquí irían el resto de las rutas de navegación de tu aplicación
        '/homeTaskPage': (context) => BlocProvider(
              create: (context) => HomeTaskPageCubit(),
              child: const HomeTaskScreen(),
            ),
      },
    );
  }
}
