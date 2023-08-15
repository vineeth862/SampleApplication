import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class address {
  String? fullAddress;
  String? pincode;
  String? floorNumber;
  String? houseNumber;

  address({
    this.fullAddress,
    this.pincode,
    this.floorNumber,
    this.houseNumber,
  });

  factory address.fromJson(Map<String, dynamic> json) =>
      _$addressFromJson(json);
  Map<String, dynamic> toJson() => _$addressToJson(this);
}
