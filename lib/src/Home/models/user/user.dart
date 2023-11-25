import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String? uId;
  String? userName;
  List<String>? location;
  String? mobile;
  String? email;
  List<String>? orders;
  String? created;
  String? lastSignedIn;
  String? age;
  String? gender;

  User(
      {this.uId,
      this.userName,
      this.email,
      this.mobile,
      this.location,
      this.orders,
      this.created,
      this.lastSignedIn,
      this.age,
      this.gender});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
