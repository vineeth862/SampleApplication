// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branchDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchDetails _$BranchDetailsFromJson(Map<String, dynamic> json) =>
    BranchDetails(
      availablePincodeDetails:
          (json['availablePincodeDetails'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      fullAddress: json['fullAddress'] as String,
      locality: json['locality'] as String,
      pincode: json['pincode'] as String,
    );

Map<String, dynamic> _$BranchDetailsToJson(BranchDetails instance) =>
    <String, dynamic>{
      'availablePincodeDetails': instance.availablePincodeDetails,
      'fullAddress': instance.fullAddress,
      'locality': instance.locality,
      'pincode': instance.pincode,
    };
