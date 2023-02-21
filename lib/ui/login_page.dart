// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  bool _obscureText = true;

  void _toogleObscureText(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion de tareas',
        style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            //icono de inicio de sesion
            Icon(
              Icons.login,
              size: 200,
              color: Color.fromARGB(255, 177, 16, 129),
            ),
            //espacio 
            SizedBox(height: 100),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 30, ),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                
                icon: Icon(Icons.security) ,
                
                
                hintText: 'Password',
                //ver password
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility: Icons.visibility_off),
                  onPressed: _toogleObscureText,
                    // Respond to button press
                  
                ),
              ),
            ),
          

            SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text('Login', 
              style: TextStyle(fontSize: 25)),
              
              
              
            ),
            
          ],
        ),
      ),
    );
  }

}