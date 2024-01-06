import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String? fullAddress;
  String? pincode;
  String? street;
  String? houseNumber;
  String? landmark;
  String? city;
  String? state;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Address(
      {this.fullAddress,
      this.pincode,
      this.street,
      this.landmark,
      this.houseNumber,
      this.city,
      this.state,
      this.firstName,
      this.lastName,
      this.phoneNumber});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$addressFromJson(json);
  Map<String, dynamic> toJson() => _$addressToJson(this);
}
