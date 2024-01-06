// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$addressFromJson(Map<String, dynamic> json) => Address(
      fullAddress: json['fullAddress'] as String?,
      pincode: json['pincode'] as String?,
      street: json['street'] as String?,
      landmark: json['landmark'] as String?,
      houseNumber: json['houseNumber'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$addressToJson(Address instance) => <String, dynamic>{
      'fullAddress': instance.fullAddress,
      'pincode': instance.pincode,
      'street': instance.street,
      'landmark': instance.landmark,
      "city": instance.city,
      "state": instance.state,
      'houseNumber': instance.houseNumber,
      "firsName": instance.firstName,
      "lastName": instance.lastName,
      "phoneName": instance.phoneNumber
    };
