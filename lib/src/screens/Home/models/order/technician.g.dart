// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Technician _$BookedFromJson(Map<String, dynamic> json) => Technician(
      assignedDateTime: json['assignedDateTime'] as String?,
      acceptedDateTime: json['acceptedDateTime'] as String?,
      completedDateTime: json['completedDateTime'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as num?,
    );

Map<String, dynamic> _$BookedToJson(Technician instance) => <String, dynamic>{
      'assignedDateTime': instance.assignedDateTime,
      'acceptedDateTime': instance.acceptedDateTime,
      'completedDateTime': instance.completedDateTime,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
