import 'package:dio/dio.dart';

import '../main.dart';
import '../models/api_response.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';

class LoginService {
  static Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    final dio = getIt<Dio>();
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      if (response.data == null) {
        return ApiResponse.error('received null body');
      }

      return ApiResponse.completed(LoginResponse.fromJson(response.data!));
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return ApiResponse.error(
            'Incorrect username or password, please try again!');
      }

      return ApiResponse.error('Something went wrong, please try again!h');
    }
  }
}
