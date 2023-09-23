import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/package/packageCard.dart';

class PackageService {
  List<PackageCard> packageList = [];

  loadPackageList() async {
    var result = await FirebaseFirestore.instance.collection('package').get();
    if (result.docs.isNotEmpty) {
      packageList =
          result.docs.map((e) => PackageCard.fromJson(e.data())).toList();
    }

    return "";
  }
}
