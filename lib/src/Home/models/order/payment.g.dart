// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
    status: json['success'],
    paymentMode: json['data']['paymentInstrument']['type'],
    cardType: json['data']['paymentInstrument']['cardType'],
    amount: json['data']['amount'],
    brn: json['data']['paymentInstrument']['brn'],
    merchantId: json['data']['merchantId'],
    merchantTransactionId: json['data']['merchantTransactionId'],
    pgTransactionId: json['data']['paymentInstrument']['pgTransactionId'],
    statusLabel: json['message'],
    transactionId: json['data']['transactionId']);

Payment _$PaymentFromDBJson(Map<String, dynamic> json) => Payment(
    status: json['status'],
    paymentMode: json['paymentMode'],
    cardType: json['cardType'],
    amount: json['amount'],
    brn: json['brn'],
    merchantId: json['merchantId'],
    merchantTransactionId: json['merchantTransactionId'],
    pgTransactionId: json['pgTransactionId'],
    statusLabel: json['statusLabel'],
    transactionId: json['transactionId'],
    transactionDate: json['transactionDate']);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'paymentMode': instance.paymentMode,
      'amount': instance.amount,
      'status': instance.status,
      'cardType': instance.cardType,
      'brn': instance.brn,
      'merchantId': instance.merchantId,
      'merchantTransactionId': instance.merchantTransactionId,
      'pgTransactionId': instance.pgTransactionId,
      'statusLabel': instance.statusLabel,
      'transactionId': instance.transactionId,
      'transactionDate': instance.transactionDate
    };
