// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booked _$BookedFromJson(Map<String, dynamic> json) => Booked(
      bookedDate: json['bookedDate'] as String?,
      bookedSlot: json['bookedSlot'] as String?,
      slot: json['slot'] as String?,
    );

Map<String, dynamic> _$BookedToJson(Booked instance) => <String, dynamic>{
      'bookedDate': instance.bookedDate,
      'bookedSlot': instance.bookedSlot,
      'slot': instance.slot,
    };
