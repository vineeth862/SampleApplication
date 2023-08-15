// import 'package:sample_application/src/screens/Home/models/order/payment.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:sample_application/src/screens/Home/models/user/user.dart';

import 'booked.dart';
import '../test/test.dart';
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String? orderNumber;
  int? carrierCode;
  String? carrierName;
  int? statusCode;
  String? statusLabel;
  String? createdDate;
  int? totalPrice;
  bool? self;
  User? user;
  User? patient;
  List<Test>? tests;
  Booked? booked;
  String? specificInstruction;
  // Payment? payment;
  String? address;

  Order({
    this.address,
    this.booked,
    this.carrierCode,
    this.carrierName,
    this.createdDate,
    this.orderNumber,
    this.patient,
    // this.payment,
    this.self,
    this.specificInstruction,
    this.statusCode,
    this.statusLabel,
    this.tests,
    this.totalPrice,
    this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
