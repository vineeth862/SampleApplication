import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String? fullAddress;
  String? pincode;
  String? floorNumber;
  String? houseNumber;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Address(
      {this.fullAddress,
      this.pincode,
      this.floorNumber,
      this.houseNumber,
      this.firstName,
      this.lastName,
      this.phoneNumber});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$addressFromJson(json);
  Map<String, dynamic> toJson() => _$addressToJson(this);
}
