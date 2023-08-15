// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      frequency: json['frequency'] as String,
      hf_test_code: json['hf_test_code'] as String,
      labCode: json['labCode'] as String,
      labName: json['labName'] as String,
      method: json['method'] as String,
      price: json['price'].toString(),
      sampleContainer: json['sampleContainer'] as String,
      sampletypename: json['sampletypename'] as String,
      tat: json['tat'] as String,
      testProcessingDays: json['testProcessingDays'] as String,
      test_code: json['test_code'] as String,
      test_des: json['test_des'] as String,
      testname: json['testname'] as String,
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'frequency': instance.frequency,
      'hf_test_code': instance.hf_test_code,
      'labCode': instance.labCode,
      'labName': instance.labName,
      'method': instance.method,
      'price': instance.price,
      'sampleContainer': instance.sampleContainer,
      'sampletypename': instance.sampletypename,
      'tat': instance.tat,
      'testProcessingDays': instance.testProcessingDays,
      'test_code': instance.test_code,
      'test_des': instance.test_des,
      'testname': instance.testname,
    };
