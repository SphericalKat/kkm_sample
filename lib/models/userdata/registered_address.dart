import 'package:json_annotation/json_annotation.dart';

part 'registered_address.g.dart';

@JsonSerializable()
class RegisteredAddress {
  RegisteredAddress({
    required this.city,
    required this.postalCode,
    required this.street,
    required this.buildingNumber,
    required this.apartmentNumber,
  });

  final String city;
  final String postalCode;
  final String street;
  final String buildingNumber;
  final String apartmentNumber;
}
