import 'package:json_annotation/json_annotation.dart';
part 'booked.g.dart';

@JsonSerializable()
class Booked {
  String? bookedDate;
  String? bookedSlot;
  String? slot;
  Booked(
      {required this.bookedDate, required this.bookedSlot, required this.slot});

  factory Booked.fromJson(Map<String, dynamic> json) => _$BookedFromJson(json);
  Map<String, dynamic> toJson() => _$BookedToJson(this);
}
