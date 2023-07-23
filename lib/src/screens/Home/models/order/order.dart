import '../booked.dart';
import '../test/test.dart';
import '../../../../authentication/models/user.dart';

class Order {
  String? orderNumber;
  int? carrierCode;
  String? carrierName;
  int? statusCode;
  String? statusLabel;
  String? createdDate;
  int? totalPrice;
  bool? self;
  Users? user;
  Users? patient;
  List<Test>? tests;
  Booked? booked;
  String? specificInstruction;
}
