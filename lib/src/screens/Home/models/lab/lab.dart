import 'branchDetails.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lab.g.dart';

@JsonSerializable(explicitToJson: true)
class Lab {
  late String labName;

  List<String> test;

  String labCode;
  String logo;

  List<BranchDetails> branchDetails;

  Lab(
      {required this.branchDetails,
      required this.test,
      required this.labName,
      required this.labCode,
      required this.logo});
  factory Lab.fromJson(Map<String, dynamic> json) => _$LabFromJson(json);
  Map<String, dynamic> toJson() => _$LabToJson(this);
}
