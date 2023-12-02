// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

address _$addressFromJson(Map<String, dynamic> json) => address(
      fullAddress: json['fullAddress'] as String?,
      pincode: json['pincode'] as String?,
      floorNumber: json['floorNumber'] as String?,
      houseNumber: json['houseNumber'] as String?,
    );

Map<String, dynamic> _$addressToJson(address instance) => <String, dynamic>{
      'fullAddress': instance.fullAddress,
      'pincode': instance.pincode,
      'floorNumber': instance.floorNumber,
      'houseNumber': instance.houseNumber,
    };
