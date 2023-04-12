
import 'package:flutter/material.dart';
import 'package:tasks/views/HomePage.dart';
import 'package:tasks/views/LoginPage.dart';

import 'cubits/auth/auth_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Login Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}