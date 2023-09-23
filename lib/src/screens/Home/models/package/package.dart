import 'package:json_annotation/json_annotation.dart';
part 'package.g.dart';

@JsonSerializable()
class Package {
  String medCaPackageCode;
  String labCode;
  String labName;
  String method;
  String price;
  String sampleContainer;
  String sampletypeName;
  String tat;
  String testProcessingDays;
  String packageCode;
  String packageDes;
  String packageName;
  bool daily;
  int labOpeningTime;
  int labClosingTime;
  String displayName;
  String testList;

  Package(
      {required this.medCaPackageCode,
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
      required this.testList});
  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
