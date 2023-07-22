import '../booked.dart';
import '../test/test.dart';
import '../user.dart';

class Order {
  String? orderNuber;
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
}
