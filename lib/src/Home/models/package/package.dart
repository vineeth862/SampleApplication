import 'package:json_annotation/json_annotation.dart';
part 'package.g.dart';

@JsonSerializable()
class Package {
  String id;
  String medCapPackageCode;
  String labCode;
  String labName;
  String method;
  int price;
  String sampleContainer;
  String sampletypeName;
  int tat;
  String testProcessingDays;
  String packageCode;
  String packageDes;
  String packageName;
  bool daily;
  int labOpeningTime;
  int labClosingTime;
  String displayName;
  String testList;
  int discount;
  int discountedPrice;
  dynamic discountedDates = [];
  dynamic discountsHistory = [];
  dynamic packageUpdationLogs;

  Package(
      {required this.id,
      required this.medCapPackageCode,
      required this.labCode,
      required this.labName,
      required this.method,
      required this.price,
      required this.sampleContainer,
      required this.sampletypeName,
      required this.tat,
      required this.testProcessingDays,
      required this.packageCode,
      required this.packageDes,
      required this.packageName,
      required this.daily,
      required this.displayName,
      required this.labOpeningTime,
      required this.labClosingTime,
      required this.testList,
      required this.discount,
      required this.discountedDates,
      required this.discountedPrice,
      required this.discountsHistory,
      required this.packageUpdationLogs});
  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
