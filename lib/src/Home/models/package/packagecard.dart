import 'package:sample_application/src/Home/models/package/package.dart';

class PackageCard {
  final String? pacName;
  final bool? pacSelcted;
  final String? pacCode;
  final String? price;
  final String? testList;
  final Package? packageObject;

  PackageCard(
      {this.pacName,
      this.pacSelcted,
      this.pacCode,
      this.price,
      this.testList,
      this.packageObject});

  factory PackageCard.fromJson(Map<String, dynamic> json) => PackageCard(
      testList: json['testList'],
      pacCode: json['packageCode'],
      pacName: json['displayName'],
      pacSelcted: false,
      packageObject: Package.fromJson(json),
      price: json['price'].toString());
}
