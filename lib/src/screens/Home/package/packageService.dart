import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/package/packageCard.dart';

class PackageService {
  List<PackageCard> packageList = [];
  Set<String> allPackagesNameList = {};
  loadPackageList() async {
    var result = await FirebaseFirestore.instance.collection('package').get();
    if (result.docs.isNotEmpty) {
      allPackagesNameList = result.docs
          .map((e) => PackageCard.fromJson(e.data()).pacName.toString())
          .toSet();
    }

    return "";
  }

  loadPackageListByLabCode(labCode) async {
    var result = await FirebaseFirestore.instance
        .collection('package')
        .where('labCode', isEqualTo: labCode)
        .get();
    if (result.docs.isNotEmpty) {
      allPackagesNameList = result.docs
          .map((e) => PackageCard.fromJson(e.data()).pacName.toString())
          .toSet();
    }

    return "";
  }

  getAllLabsByPackage(String displayName) async {
    var result = await FirebaseFirestore.instance
        .collection('package')
        .where("displayName", isEqualTo: displayName)
        .get();
    if (result.docs.isNotEmpty) {
      packageList =
          result.docs.map((e) => PackageCard.fromJson(e.data())).toList();
    }

    return "";
  }
}
