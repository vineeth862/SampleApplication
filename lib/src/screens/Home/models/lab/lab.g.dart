// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lab _$LabFromJson(Map<String, dynamic> json) => Lab(
      branchDetails: (json['branchDetails'] as List<dynamic>)
          .map((e) => BranchDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      test: (json['test'] as List<dynamic>).map((e) => e as String).toList(),
      labName: json['labName'] as String,
      hf_lab_code: json['hf_lab_code'] as String,
    );

Map<String, dynamic> _$LabToJson(Lab instance) => <String, dynamic>{
      'labName': instance.labName,
      'test': instance.test,
      'hf_lab_code': instance.hf_lab_code,
      'branchDetails': instance.branchDetails.map((e) => e.toJson()).toList(),
    };