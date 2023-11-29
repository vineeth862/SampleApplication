import 'package:sample_application/src/Home/models/package/package.dart';

class PackageSliderCard {
  final String? title;
  final String? image;
  final String? labCode;
  final String? labName;

  PackageSliderCard({this.title, this.image, this.labCode, this.labName});

  factory PackageSliderCard.fromJson(Map<String, dynamic> json) =>
      PackageSliderCard(
          title: json['title'],
          image: json['image'],
          labCode: json['labCode'],
          labName: json['labName']);
}
