import 'package:flutter/material.dart';

import '../../screens/Home/models/package/package.dart';
import '../../screens/Home/models/test/test.dart';

class SelectedTestState with ChangeNotifier {
  List<Test> selectedTest = [];
  List<Package> selectedPackage = [];
  bool _detailExpanded = false;

  int totalPriceSum = 0;
  int totalDiscountedPriceSum = 0;
  int discount = 0;

  List<Test> get getSelectedTest {
    return selectedTest;
  }

  List<Package> get getSelectedPackage {
    return selectedPackage;
  }

  void addTest(test) async {
    selectedTest.add(test);
    await getTotalSum();
    notifyListeners();
  }

  void removeTest(test) {
    selectedTest.remove(test);
    notifyListeners();
  }

  void removeAllTest() {
    selectedTest.clear();
    notifyListeners();
  }

  void addPackage(package) {
    selectedPackage.add(package);
    notifyListeners();
  }

  void removePackage(package) {
    selectedPackage.remove(package);
    notifyListeners();
  }

  void removeAllPackage() {
    selectedPackage.clear();
    notifyListeners();
  }

  bool get isDetailExpanded {
    return _detailExpanded;
  }

  void toggelDetailExpanded() {
    _detailExpanded = !_detailExpanded;
    notifyListeners();
  }

  void setDetailExpanded(value) {
    _detailExpanded = value;
    notifyListeners();
  }

  getTotalSum() {
    int tempTotalPriceSum = 0;
    int tempTotalDiscountedPriceSum = 0;

    for (var item in selectedTest) {
      tempTotalPriceSum += int.parse(item.price);
      tempTotalDiscountedPriceSum += int.parse(item.discountedPrice);
    }
    totalPriceSum = tempTotalPriceSum;
    totalDiscountedPriceSum = tempTotalDiscountedPriceSum;
    discount =
        (((totalPriceSum - totalDiscountedPriceSum) / totalPriceSum) * 100)
            .toInt();
    print(totalDiscountedPriceSum);
    notifyListeners();
    return "";
  }
}
