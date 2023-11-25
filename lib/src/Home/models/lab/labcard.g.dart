// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabCard _$LabCardFromJson(Map<String, dynamic> json) => LabCard(
      name: json['name'] as String,
      test: json['test'] as String,
      testCode: json['testCode'] as String,
      labCode: json['labCode'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$LabCardToJson(LabCard instance) => <String, dynamic>{
      'name': instance.name,
      'test': instance.test,
      'testCode': instance.testCode,
      'labCode': instance.labCode,
      'location': instance.location,
    };
