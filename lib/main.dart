// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:tasks/screens/login/login_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Demo',
//       home: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(''),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           LoginScreen(),

//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tasks/screen/login/login_screen.dart';
import 'package:tasks/screen/task/task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/task_panel': (context) => TaskPanel(),
      },
    );
  }
}
