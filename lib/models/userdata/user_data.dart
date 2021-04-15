import 'package:json_annotation/json_annotation.dart';

import 'registered_address.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  UserData({
    required this.pesel,
    required this.birthDate,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.photoUrl,
    required this.registeredAddress,
  });

  final String pesel;
  final DateTime birthDate;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String photoUrl;
  final RegisteredAddress registeredAddress;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
