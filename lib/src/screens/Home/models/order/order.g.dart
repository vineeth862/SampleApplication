// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      address: json['address'] as String?,
      booked: json['booked'] == null
          ? null
          : Booked.fromJson(json['booked'] as Map<String, dynamic>),
      carrierCode: json['carrierCode'] as int?,
      carrierName: json['carrierName'] as String?,
      createdDate: json['createdDate'] as String?,
      orderNumber: json['orderNumber'] as String?,
      patient: json['patient'] == null
          ? null
          : User.fromJson(json['patient'] as Map<String, dynamic>),
      self: json['self'] as bool?,
      specificInstruction: json['specificInstruction'] as String?,
      statusCode: json['statusCode'] as int?,
      statusLabel: json['statusLabel'] as String?,
      tests: (json['tests'] as List<dynamic>?)
          ?.map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'carrierCode': instance.carrierCode,
      'carrierName': instance.carrierName,
      'statusCode': instance.statusCode,
      'statusLabel': instance.statusLabel,
      'createdDate': instance.createdDate,
      'totalPrice': instance.totalPrice,
      'self': instance.self,
      'user': instance.user?.toJson(),
      'patient': instance.patient?.toJson(),
      'tests': instance.tests?.map((e) => e.toJson()).toList(),
      'booked': instance.booked?.toJson(),
      'specificInstruction': instance.specificInstruction,
      'address': instance.address,
    };
