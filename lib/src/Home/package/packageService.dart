import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/package/packageCard.dart';

class PackageService {
  List<PackageCard> packageList = [];
  Set<String> allPackagesNameList = {};
  loadPackageList() async {
    var result =
        await FirebaseFirestore.instance.collection('prod-package').get();
    if (result.docs.isNotEmpty) {
      allPackagesNameList = result.docs
          .map((e) => PackageCard.fromJson(e.data()).pacName.toString())
          .toSet();
    }

    return "";
  }

  loadPackageListByTitle(title) async {
    var result = await FirebaseFirestore.instance
        .collection('prod-package')
        .where('displayName', isEqualTo: title)
        .get();
    if (result.docs.isNotEmpty) {
      allPackagesNameList = result.docs
          .map((e) => PackageCard.fromJson(e.data()).pacName.toString())
          .toSet();
    }

    return "";
  }

  loadPackageListByLabCode(displyName) async {
    var result = await FirebaseFirestore.instance
        .collection('prod-package')
        .where('displayName', isEqualTo: displyName)
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
        .collection('prod-package')
        .where("displayName", isEqualTo: displayName)
        .get();
    if (result.docs.isNotEmpty) {
      packageList =
          result.docs.map((e) => PackageCard.fromJson(e.data())).toList();
    }

    return "";
  }
}
