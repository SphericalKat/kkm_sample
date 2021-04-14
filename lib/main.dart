import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'routes/login.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
      baseUrl: 'https://api.kkm.krakow.pl/api/v1',
      contentType: Headers.jsonContentType,
    )),
  );
  runApp(MyApp());
}

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
