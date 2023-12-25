import 'package:json_annotation/json_annotation.dart';
part 'payment.g.dart';

@JsonSerializable()
class Payment {
  bool status;
  String? statusLabel;
  String? paymentMode;
  String? merchantId;
  String? merchantTransactionId;
  String? transactionId;
  int amount;
  String pgTransactionId;
  String? brn;

  String? cardType;

  Payment(
      {required this.paymentMode,
      required this.status,
      required this.statusLabel,
      required this.amount,
      required this.brn,
      required this.merchantId,
      required this.merchantTransactionId,
      required this.pgTransactionId,
      required this.transactionId,
      this.cardType});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  factory Payment.fromDBJson(Map<String, dynamic> json) =>
      _$PaymentFromDBJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
