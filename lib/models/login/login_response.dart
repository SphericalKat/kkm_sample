import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final String refresh;
  final DateTime expires;

  @JsonKey(ignore: true)
  final int responseCode;

  LoginResponse({
    required this.token,
    required this.refresh,
    required this.expires,
    this.responseCode = 200,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
