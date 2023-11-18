import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/screens/Home/models/category/category.dart'
    as category;

import '../models/lab/labMasterData.dart';

class ExploreService {
  final _db = FirebaseFirestore.instance;
  fetchCategoryList() async {
    final categoryList = await _db
        .collection("prod-package/category/popularCategory")
        //.where("type", isEqualTo: 'category')
        .get();

    if (categoryList.docs.isNotEmpty) {
      return categoryList.docs.map((doc) {
        return category.Category.fromJson(doc.data());
      }).toList();
    }
    return [];
  }

  fetchLabList() async {
    final categoryList = await _db
        .collection("masterData")
        .where("type", isEqualTo: 'lab-logo')
        .get();

    if (categoryList.docs.isNotEmpty) {
      return categoryList.docs.map((doc) {
        return LabMasterData.fromJson(doc.data());
      }).toList();
    }
    return [];
  }

  fetchMaleCategoryList() async {
    final categoryList =
        await _db.collection("prod-package/category/men").get();
    if (categoryList.docs.isNotEmpty) {
      return categoryList.docs.map((doc) {
        return category.Category.fromJson(doc.data());
      }).toList();
    }
    return [];
  }

  fetchFemaleCategoryList() async {
    final categoryList =
        await _db.collection("prod-package/category/women").get();
    if (categoryList.docs.isNotEmpty) {
      return categoryList.docs.map((doc) {
        return category.Category.fromJson(doc.data());
      }).toList();
    }
    return [];
  }
}
