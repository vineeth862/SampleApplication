// import 'package:sample_application/src/Home/models/order/payment.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:sample_application/src/Home/models/order/payment.dart';
import 'package:sample_application/src/Home/models/order/technician.dart';
import 'package:sample_application/src/Home/models/package/package.dart';
import 'package:sample_application/src/Home/models/user/address.dart';
import 'package:sample_application/src/Home/models/user/user.dart';

import '../user/address.dart';
import 'booked.dart';
import '../test/test.dart';
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String? orderNumber;
  int? statusCode = 0;
  String? statusLabel;
  String? createdDate;
  int? totalPrice;
  bool? self;
  User? user;
  User? patient;
  List<Test>? tests;
  List<Package>? packages;
  String? labCode;
  String? labName;
  Booked? booked;
  String? specificInstruction;
  Payment? payment;
  Address? address;
  Technician? technician;

  Order(
      {this.address,
      this.booked,
      this.createdDate,
      this.orderNumber,
      this.patient,
      this.payment,
      this.self,
      this.specificInstruction,
      this.statusCode,
      this.statusLabel,
      this.tests,
      this.packages,
      this.totalPrice,
      this.user,
      this.labCode,
      this.labName,
      this.technician});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
