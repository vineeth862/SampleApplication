// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uId: json['uId'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orders:
          (json['orders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      created: json['created'] as String?,
      lastSignedIn: json['lastSignedIn'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uId': instance.uId,
      'userName': instance.userName,
      'location': instance.location,
      'mobile': instance.mobile,
      'email': instance.email,
      'orders': instance.orders,
      'created': instance.created,
      'lastSignedIn': instance.lastSignedIn,
      'age': instance.age,
      'gender': instance.gender,
    };
