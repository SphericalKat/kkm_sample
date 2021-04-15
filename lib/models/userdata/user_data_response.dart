import 'package:json_annotation/json_annotation.dart';

import 'mkkm_data.dart';
import 'user_data.dart';

part 'user_data_response.g.dart';

@JsonSerializable()
class UserDataResponse {
  UserDataResponse({
    required this.userData,
    required this.mkkmData,
    required this.cardsNotAdded,
    required this.code,
    required this.message,
  });

  final UserData userData;
  final MkkmData mkkmData;
  final bool cardsNotAdded;
  final dynamic code;
  final dynamic message;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}
