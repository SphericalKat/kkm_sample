import 'package:flutter/material.dart';
import 'routes/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KKM',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginForm(),
    );
  }
}
