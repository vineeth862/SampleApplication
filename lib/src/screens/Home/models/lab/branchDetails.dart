import 'package:json_annotation/json_annotation.dart';
part 'branchDetails.g.dart';

@JsonSerializable()
class BranchDetails {
  List<String> availablePincodeDetails;

  String fullAddress;

  String locality;

  String pincode;

  BranchDetails(
      {required this.availablePincodeDetails,
      required this.fullAddress,
      required this.locality,
      required this.pincode});

  factory BranchDetails.fromJson(Map<String, dynamic> json) =>
      _$BranchDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$BranchDetailsToJson(this);
}
