// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestCard _$TestCardFromJson(Map<String, dynamic> json) => TestCard(
      name: json['testname'] as String,
      test: json['tat'] as String,
      testSelcted: false,
      testCode: json['hf_test_code'] as String,
      price: json['price'].toString() as String,
      labName: json['labName'] as String,
      testObject: Test.fromJson(json as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestCardToJson(TestCard instance) => <String, dynamic>{
      'name': instance.name,
      'test': instance.test,
      'testSelcted': instance.testSelcted,
      'testCode': instance.testCode,
      'price': instance.price,
      'labName': instance.labName,
      'testObject': instance.testObject.toJson(),
    };
