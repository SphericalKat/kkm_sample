import 'package:dio/dio.dart';
import '../main.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';

class LoginService {
  static Future<LoginResponse?> login(LoginRequest request) async {
    final dio = getIt<Dio>();
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      if (response.data == null) {
        return null;
      }

      return LoginResponse.fromJson(response.data!);
    } on DioError catch (e) {
      return LoginResponse(
        token: '',
        refresh: '',
        expires: DateTime.now(),
        responseCode: e.response?.statusCode ?? 0,
      );
    }
  }
}
