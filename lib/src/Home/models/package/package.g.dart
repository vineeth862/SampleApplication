// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: json['id'],
      medCapPackageCode: json['medCaPackageCode'].toString(),
      labCode: json['labCode'] as String,
      labName: json['labName'] as String,
      method: json['method'] as String,
      price: json['price'].toString(),
      sampleContainer: json['sampleContainer'] as String,
      sampletypeName: json['sampletypeName'] as String,
      tat: json['tat'].toString(),
      testProcessingDays: json['testProcessingDays'].toString(),
      packageCode: json['packageCode'].toString(),
      packageDes: json['packageDes'] as String,
      packageName: json['packageName'] as String,
      daily: json['daily'],
      displayName: json['displayName'],
      labOpeningTime: json['labOpeningTime'],
      labClosingTime: json['labClosingTime'],
      testList: json['testList'],
      discount: json['discount'],
      discountedDates: json['discountedDates'],
      discountedPrice: json['discountedPrice'],
      discountsHistory: json['discountsHistory'],
      packageUpdationLogs: json['packageUpdationLogs'],
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'medCapPackageCode': instance.medCapPackageCode,
      'labCode': instance.labCode,
      'labName': instance.labName,
      'method': instance.method,
      'price': instance.price,
      'sampleContainer': instance.sampleContainer,
      'sampletypeName': instance.sampletypeName,
      'tat': instance.tat,
      'testProcessingDays': instance.testProcessingDays,
      'packageCode': instance.packageCode,
      'packageDes': instance.packageDes,
      'packageName': instance.packageName,
      'displayName': instance.displayName,
      'daily': instance.daily,
      'labOpeningTime': instance.labOpeningTime,
      'labClosingTime': instance.labClosingTime,
      'testList': instance.testList,
      'discount': instance.discount,
      'discountedDates': instance.discountedDates,
      'discountedPrice': instance.discountedPrice,
      'discountsHistory': instance.discountsHistory,
      'packageUpdationLogs': instance.packageUpdationLogs
    };
