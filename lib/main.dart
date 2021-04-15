import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kkm_sample/interceptors/auth_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/home.dart';
import 'routes/login.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  getIt.registerSingletonWithDependencies<Dio>(
      () => Dio(BaseOptions(
            baseUrl: 'https://api.kkm.krakow.pl/api/v1',
            contentType: Headers.jsonContentType,
          ))
            ..interceptors.add(AuthInterceptor()),
      dependsOn: [SharedPreferences]);

  await getIt.allReady();

  final prefs = getIt<SharedPreferences>();
  final isLoggedIn = (prefs.getString('AUTH_TOKEN') ?? '') != '';

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
