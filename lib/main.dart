// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
//import material dart file

//import material dart


import 'package:tasks/ui/login_page.dart';
//impor

void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),

      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/login":(context) => LoginPage(),
        
        
      },
     
    );
  }
}