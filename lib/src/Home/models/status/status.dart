class Status {
  final String? type;
  final num? statusCode;
  final num? step;
  final String? statusLabel;

  Status({this.statusCode, this.statusLabel, this.step, this.type});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
      statusCode: json['statusCode'] as num,
      statusLabel: json['statusLabel'] as String,
      step: json['step'] as num,
      type: json['type'] as String);

  Map<String, dynamic> toJson(Status instance) => <String, dynamic>{
        'statusCode': instance.statusCode,
        'statusLabel': instance.statusLabel,
        'step': instance.step,
        'type': instance.type,
      };
}
