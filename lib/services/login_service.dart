import 'package:dio/dio.dart';
import 'package:kkm_sample/models/login/refresh_request.dart';
import 'package:kkm_sample/utils/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      return ApiResponse.error('Something went wrong, please try again!');
    }
  }

  static Future<ApiResponse<LoginResponse>> _refresh(
      RefreshRequest request) async {
    final dio = getIt<Dio>();
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/auth/token/recover',
        data: request.toJson(),
      );

      if (response.data == null) {
        return ApiResponse.error('received null body');
      }

      return ApiResponse.completed(LoginResponse.fromJson(response.data!));
    } on DioError catch (e) {
      print(e);
      return ApiResponse.error('Something went wrong, please try again!');
    }
  }

  static Future<void> refresh() async {
    final prefs = getIt<SharedPreferences>();
    final token = prefs.getString('REFRESH_TOKEN') ?? '';
    try {
      final deviceInfo = await getDeviceId();
      final deviceId = deviceInfo.item1;
      final deviceName = deviceInfo.item2;

      final refreshRequest = RefreshRequest(
        token: token,
        deviceId: deviceId,
        deviceName: deviceName,
      );

      final refreshResponse = await _refresh(refreshRequest);

      if (refreshResponse.status == Status.ERROR) {
        throw Error();
      }

      prefs.setString('AUTH_TOKEN', refreshResponse.data!.token);
      prefs.setString('REFRESH_TOKEN', refreshResponse.data!.refresh);

    } catch (e) {
      prefs.setString('AUTH_TOKEN', '');
      prefs.setString('REFRESH_TOKEN', '');
    }
  }
}
