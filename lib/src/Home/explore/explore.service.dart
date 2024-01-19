import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/Home/models/category/category.dart'
    as category;

import '../models/category/category.dart';
import '../models/lab/labMasterData.dart';
import '../models/package/packageSliderCard.dart';

class ExploreService {
  final _db = FirebaseFirestore.instance;
  Future<List<Category>> fetchCategoryList() async {
    final categoryList = await _db
        .collection("prod-category/category/popularCategory")
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

  Future<List<Category>> fetchMaleCategoryList() async {
    final categoryList =
        await _db.collection("prod-category/category/men").get();
    if (categoryList.docs.isNotEmpty) {
      return categoryList.docs.map((doc) {
        return category.Category.fromJson(doc.data());
      }).toList();
    }
    return [];
  }

  Future<List<Category>> fetchFemaleCategoryList() async {
    final categoryList =
        await _db.collection("prod-category/category/women").get();
    if (categoryList.docs.isNotEmpty) {
      return categoryList.docs.map((doc) {
        return category.Category.fromJson(doc.data());
      }).toList();
    }
    return [];
  }

  fetchPackageCardsList() async {
    final packageCardList = await _db.collection("prod-package-card").get();
    if (packageCardList.docs.isNotEmpty) {
      return packageCardList.docs.map((doc) {
        return PackageSliderCard.fromJson(doc.data());
      }).toList();
    }

    return [];
  }

  fetchSliderCards(type) async {
    final sliderCards = await _db
        .collection("prod-slider")
        .where("sliderType", isEqualTo: type)
        .get();
    if (sliderCards.docs.isNotEmpty) {
      return sliderCards.docs.map((doc) {
        return doc.get("imageUrl").toString();
      }).toList();
    }
    return [];
  }

  fetchTestDescription(displayName) async {
    final testData = await _db
        .collection("prod-test")
        .where("displayName", isEqualTo: displayName)
        .get();
    if (testData.docs.isNotEmpty) {
      return testData.docs.map((doc) {
        return doc.get("testDes").toString();
      }).toList();
    }
    return "";
  }

  fetchPackageDescription(displayName) async {
    final packageData = await _db
        .collection("prod-package")
        .where("displayName", isEqualTo: displayName)
        .get();
    if (packageData.docs.isNotEmpty) {
      return packageData.docs.map((doc) {
        return doc.get("testList").toString();
      }).toList();
    }
    return "";
  }
}
