import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../services/login_service.dart';

class AuthInterceptor extends Interceptor {
  final prefs = getIt<SharedPreferences>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    final token = prefs.getString('AUTH_TOKEN');
    options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    String token = prefs.getString('AUTH_TOKEN') ?? '';

    if (token != '') {
      if (err.response?.statusCode == 401) {
        await LoginService.refresh();
        token = prefs.getString('AUTH_TOKEN') ?? '';
      }
    }
  }
}
