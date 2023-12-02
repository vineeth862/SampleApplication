import 'package:json_annotation/json_annotation.dart';
part 'technician.g.dart';

@JsonSerializable()
class Technician {
  String? assignedDateTime;
  String? acceptedDateTime;
  String? completedDateTime;
  String? name;
  String? email;
  String? phone;
  Technician({
    this.assignedDateTime,
    this.name,
    this.email,
    this.phone,
    this.acceptedDateTime,
    this.completedDateTime,
  });

  factory Technician.fromJson(Map<String, dynamic> json) =>
      _$BookedFromJson(json);
  Map<String, dynamic> toJson() => _$BookedToJson(this);
}
