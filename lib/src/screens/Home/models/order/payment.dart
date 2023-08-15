import 'package:json_annotation/json_annotation.dart';
part 'payment.g.dart';

@JsonSerializable()
class Payment {
  String? paymentMode;
  Payment({this.paymentMode});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
