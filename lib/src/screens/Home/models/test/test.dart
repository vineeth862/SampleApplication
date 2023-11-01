import 'package:json_annotation/json_annotation.dart';
part 'test.g.dart';

@JsonSerializable()
class Test {
  String medCapTestCode;
  String labCode;
  String labName;
  String method;
  String price;
  String sampleContainer;
  String sampletypeName;
  String tat;
  String testProcessingDays;
  String testCode;
  String testDes;
  String testName;
  String category;
  bool daily;
  int labOpeningTime;
  int labClosingTime;
  String displayName;
  String discount;

  String discountedPrice;

  Test(
      {required this.medCapTestCode,
      required this.labCode,
      required this.labName,
      required this.method,
      required this.price,
      required this.sampleContainer,
      required this.sampletypeName,
      required this.tat,
      required this.testProcessingDays,
      required this.testCode,
      required this.testDes,
      required this.testName,
      required this.category,
      required this.daily,
      required this.displayName,
      required this.labOpeningTime,
      required this.labClosingTime,
      required this.discount,
      required this.discountedPrice});
  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}
