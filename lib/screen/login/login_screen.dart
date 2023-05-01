// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unnecessary_const

// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasks/app/constants.dart';

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
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is AuthInitial){

          }else if(state is AuthInternetFailure){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: Globals.checkInternet
            );
          }else if(state is AuthServerFailure){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: Globals.checkServer
            );
          }else if(state is AuthCredentialsFailure){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'Credenciales invalidas. Revise por favor.'
            );
          }else if(state is AuthSuccess){
            Navigator.pushNamed(context, '/task_panel');
          }else{
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: Globals.checkServer
            );
          }
        },
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
                            borderRadius: BorderRadius.circular(1000),
                            color: Color(0xFF004070),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            size: 300,
                            color: const Color(0xffffcc00),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF004070)),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 124, 119, 119),
                              ),
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
                            color: const Color(0xFF004070),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 124, 119, 119),
                              ),
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
                                color: const Color(0xFF004070),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(25)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().logIn(
                                          username: _username,
                                          password: _password,
                                        );
                                  }
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
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
