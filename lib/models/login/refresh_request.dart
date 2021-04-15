import 'package:json_annotation/json_annotation.dart';

part 'refresh_request.g.dart';

@JsonSerializable()
class RefreshRequest {
  final String token;
  final String deviceId;
  final String deviceName;

  RefreshRequest({
    required this.token,
    required this.deviceId,
    required this.deviceName,
  });

  factory RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshRequestToJson(this);
}
