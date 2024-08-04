import 'package:flutter/material.dart';
import 'package:my_project/screens/password_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boveda de constraseñas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordListScreen(),
    );
  }
}
