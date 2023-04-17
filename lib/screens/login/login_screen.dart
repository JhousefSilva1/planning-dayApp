// ignore_for_file: unused_field, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tasks/data/services/authentication_service.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          //Positioned.fill(
          //child: Image.network(
          //'https://picsum.photos/400/800',
          //fit: BoxFit.cover,
          //),
          //),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icono de tareas
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 15, 209, 235),
                    ),
                    child: const Icon(
                      Icons.assignment,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 100),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 15, 209, 235),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        labelText: 'Username',
                        //sin linea
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // ignore: avoid_unnecessary_containers
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 15, 209, 235),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Aquí puede agregar la lógica de autenticación.
                        AuthenticationService _authenticationService =
                            AuthenticationService();
                        String authenticated /*autenticado*/ =
                            await _authenticationService.logIn /*autenticar*/ (
                                username: _username, password: _password);
                        print(authenticated);
                      }
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
