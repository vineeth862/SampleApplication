// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
    medCapTestCode: json['medCapTestCode'] as String,
    labCode: json['labCode'] as String,
    labName: json['labName'] as String,
    method: json['method'] as String,
    price: json['price'].toString(),
    sampleContainer: json['sampleContainer'] as String,
    sampletypeName: json['sampletypeName'] as String,
    tat: json['tat'].toString(),
    testProcessingDays: json['testProcessingDays'].toString(),
    testCode: json['testCode'].toString(),
    testDes: json['testDes'] as String,
    testName: json['testName'] as String,
    category: json['category'],
    daily: json['daily'],
    displayName: json['displayName'],
    labOpeningTime: json['labOpeningTime'],
    labClosingTime: json['labClosingTime']);

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'medCapTestCode': instance.medCapTestCode,
      'labCode': instance.labCode,
      'labName': instance.labName,
      'method': instance.method,
      'price': instance.price,
      'sampleContainer': instance.sampleContainer,
      'sampletypeName': instance.sampletypeName,
      'tat': instance.tat,
      'testProcessingDays': instance.testProcessingDays,
      'testCode': instance.testCode,
      'testDes': instance.testDes,
      'testName': instance.testName,
      'displayName': instance.displayName,
      'daily': instance.daily,
      'category': instance.category,
      'labOpeningTime': instance.labOpeningTime,
      'labClosingTime': instance.labClosingTime
    };
