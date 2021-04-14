import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String username;
  final String password;
  final String deviceId;
  final String deviceName;

  @JsonKey(defaultValue: true)
  final bool rememberMe;

  LoginRequest({
    required this.username,
    required this.password,
    required this.deviceId,
    required this.deviceName,
    this.rememberMe = true
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
