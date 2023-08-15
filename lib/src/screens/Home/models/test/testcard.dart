// import 'package:json_annotation/json_annotation.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
part 'testcard.g.dart';

class TestCard {
  final String name;
  final String test;
  final bool testSelcted;
  final String testCode;
  final String price;
  final String labName;
  final Test testObject;

  TestCard(
      {required this.name,
      required this.test,
      required this.testSelcted,
      required this.testCode,
      required this.price,
      required this.labName,
      required this.testObject});

  factory TestCard.fromJson(Map<String, dynamic> json) =>
      _$TestCardFromJson(json);
  Map<String, dynamic> toJson() => _$TestCardToJson(this);
}
