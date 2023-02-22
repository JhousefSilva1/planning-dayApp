// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(fontSize: 20),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Icon(
              Icons.task,
              size: 200,
              color: Color.fromARGB(255, 177, 16, 129),
            ),
            SizedBox(height: 100),
            Text('Bienvenido a la pagina principal'),
            
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Text('Siguiente'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, exit(1),);
              },
              child: Text('Salir'),
            ),
            SizedBox(height: 30),Align(
              alignment: Alignment.bottomCenter,
              child: Text('© 2021 Todos los derechos reservados'),
            ),

          ],
          ),

      )
  

    

    );
  }



}

