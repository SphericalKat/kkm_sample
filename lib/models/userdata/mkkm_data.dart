import 'package:json_annotation/json_annotation.dart';

part 'mkkm_data.g.dart';

@JsonSerializable()
class MkkmData {
  MkkmData({
    required this.customerCode,
    required this.hasInhabitantPrivilege,
    required this.inhabitantPrivilegeDateFrom,
    required this.inhabitantPrivilegeDateTo,
  });

  final String customerCode;
  final bool hasInhabitantPrivilege;
  final dynamic inhabitantPrivilegeDateFrom;
  final dynamic inhabitantPrivilegeDateTo;

  factory MkkmData.fromJson(Map<String, dynamic> json) =>
      _$MkkmDataFromJson(json);

  Map<String, dynamic> toJson() => _$MkkmDataToJson(this);
}
