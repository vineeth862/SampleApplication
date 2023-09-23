// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
    medCaPackageCode: json['medCaPackageCode'] as String,
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
    testList: json['testList']);

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'medCapTestCode': instance.medCaPackageCode,
      'labCode': instance.labCode,
      'labName': instance.labName,
      'method': instance.method,
      'price': instance.price,
      'sampleContainer': instance.sampleContainer,
      'sampletypeName': instance.sampletypeName,
      'tat': instance.tat,
      'testProcessingDays': instance.testProcessingDays,
      'testCode': instance.packageCode,
      'testDes': instance.packageDes,
      'testName': instance.packageName,
      'displayName': instance.displayName,
      'daily': instance.daily,
      'labOpeningTime': instance.labOpeningTime,
      'labClosingTime': instance.labClosingTime,
      'testList': instance.testList
    };
