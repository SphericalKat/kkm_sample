import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/home.dart';
import 'routes/login.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
      baseUrl: 'https://api.kkm.krakow.pl/api/v1',
      contentType: Headers.jsonContentType,
    )),
  );
  getIt.registerSingleton<SharedPreferences>(prefs);

  final isLoggedIn = prefs.getString('AUTH_TOKEN') != null;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KKM',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/login': (context) => const LoginForm(),
        '/home': (context) => const HomePage(),
      },
      initialRoute: isLoggedIn ? '/home' : '/login',
    );
  }
}
