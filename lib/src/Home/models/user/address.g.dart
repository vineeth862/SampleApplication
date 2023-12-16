// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$addressFromJson(Map<String, dynamic> json) => Address(
      fullAddress: json['fullAddress'] as String?,
      pincode: json['pincode'] as String?,
      floorNumber: json['floorNumber'] as String?,
      houseNumber: json['houseNumber'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$addressToJson(Address instance) => <String, dynamic>{
      'fullAddress': instance.fullAddress,
      'pincode': instance.pincode,
      'floorNumber': instance.floorNumber,
      'houseNumber': instance.houseNumber,
      "firsName": instance.firstName,
      "lastName": instance.lastName,
      "phoneName": instance.phoneNumber
    };
