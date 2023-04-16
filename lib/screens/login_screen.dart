import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/cubit/login_cubit.dart';
import 'package:tasks/screens/home_task_screen.dart';
import 'package:tasks/screens/login_state.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);

  static const ruterName = '/login';

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passworddController = TextEditingController();

  void _onLoginButtonPressed() {
    // ignore: unused_local_variable
    final username = _usernameController.text;
    // ignore: unused_local_variable
    final passwordd = _passworddController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestios de tareas'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        /*
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Usuario',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextField(
                        controller: _passworddController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contraseña',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _onLoginButtonPressed,
                      child: const Text('Iniciar sesión'),
                    ),
                  ],
                ),
              );
            } else if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoginSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Inicio de sesión exitoso',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginCubit>(context).logout();
                      },
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),*/

        child: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                        labelText: 'Usuario',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  //
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: _passworddController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                        labelText: 'Contraseña',
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        //
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          textStyle: const TextStyle(fontSize: 30),

                          // ignore: prefer_const_constructors
                        ),
                        child: state is LoginLoading
                            ? const CircularProgressIndicator()
                            : const Text('Iniciar sesión')),
                  ),
                ],
              ));
        }),
      ),
    );
  }
}
