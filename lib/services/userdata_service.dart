import 'package:dio/dio.dart';

import '../main.dart';
import '../models/api_response.dart';
import '../models/userdata/user_data_response.dart';

class UserDataService {
  static Future<ApiResponse<UserDataResponse>> getUserData() async {
    final dio = getIt<Dio>();
    try {
      final Response<Map<String, dynamic>> response =
          await dio.get('account/user-data');

      if (response.data == null) {
        return ApiResponse.error('received null body');
      }

      return ApiResponse.completed(UserDataResponse.fromJson(response.data!));
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return ApiResponse.error(
            'Incorrect username or password, please try again!');
      }

      return ApiResponse.error('Something went wrong, please try again!');
    }
  }
}
