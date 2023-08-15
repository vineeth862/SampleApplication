// import 'package:sample_application/src/screens/Home/models/order/payment.dart';

import '../booked.dart';
import '../test/test.dart';
import 'package:sample_application/src/authentication/models/user.dart';

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

  toJson() {
    return {
      "orderNumber": orderNumber,
      "carrierCode": carrierCode,
      "carrierName": carrierName,
      "statusCode": statusCode,
      "statusLabel": statusLabel,
      "createdDate": createdDate,
      "totalPrice": totalPrice,
      "self": self,
      "user": user?.toJson(),
      "patient": patient?.toJson(),
      "tests": [...tests!.map((e) => e.toJson())],
      "booked": booked?.toJson(),
      "specificInstruction": specificInstruction,
      // "payment": payment,
      "address": address,
    };
  }
}
