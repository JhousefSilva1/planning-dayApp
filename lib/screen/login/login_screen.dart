// ignore_for_file: avoid_print

// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/auth/auth_state.dart';

import '../../data/service/auth_service.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late String _username = '';
  late String _password = '';
  late String hexColorFont = 'ffcc00';

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF004070),
              title: const Text('Task Managment',
                  style: TextStyle(
                    color: Color(0xffffcc00),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 15, 200, 235),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 15, 200, 235),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the username';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _username = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 15, 200, 235),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _password = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                //boton mas grande

                                color: const Color.fromARGB(255, 15, 200, 235),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // Aquí puede agregar la lógica de autenticación.
                                    AuthService
                                        _authenticationService =
                                        AuthService();
                                    String authenticated /*autenticado*/ =
                                        await _authenticationService
                                            .logIn /*autenticar*/ (
                                                username: _username,
                                                password: _password);
                                    print("data: $authenticated");
                                    if (authenticated == '0001') {
                                      //alertDialog
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text(
                                                "Usuario o contraseña incorrectos"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      //alertDialog
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Bienvenido"),
                                            content: const Text(
                                                "Usuario autenticado"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/task_panel');
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,

                                    //fontfamily
                                  ),
                                ),
                              ),
                            ),

                            //button signup
                            const SizedBox(width: 30),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                //boton mas grande

                                color: const Color.fromARGB(255, 15, 200, 235),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().logIn(
                                          username: _username,
                                          password: _password,
                                        );
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    //fontfamily
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}