import 'package:json_annotation/json_annotation.dart';
part 'labcard.g.dart';

@JsonSerializable()
class LabCard {
  final String name;
  final String test;
  final String testCode;
  final String labCode;
  final String location;

  LabCard(
      {required this.name,
      required this.test,
      required this.testCode,
      required this.labCode,
      required this.location});
  factory LabCard.fromJson(Map<String, dynamic> json) =>
      _$LabCardFromJson(json);
  Map<String, dynamic> toJson() => _$LabCardToJson(this);
}
