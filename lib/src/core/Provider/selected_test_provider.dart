import 'package:flutter/material.dart';

import '../../Home/models/package/package.dart';
import '../../Home/models/test/test.dart';

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

  void removeTest(test) async {
    selectedTest.remove(test);

    await getTotalSum();
    notifyListeners();
  }

  void removeAllTest() async {
    selectedTest.clear();
    await getTotalSum();
    notifyListeners();
  }

  void addPackage(package) async {
    selectedPackage.add(package);
    await getTotalSum();
    notifyListeners();
  }

  void removePackage(package) async {
    selectedPackage.remove(package);
    await getTotalSum();
    notifyListeners();
  }

  void removeAllPackage() async {
    selectedPackage.clear();
    await getTotalSum();
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
    for (var item in selectedPackage) {
      tempTotalPriceSum += int.parse(item.price.toString());
      tempTotalDiscountedPriceSum += int.parse(item.discountedPrice.toString());
    }
    totalPriceSum = tempTotalPriceSum;
    totalDiscountedPriceSum = tempTotalDiscountedPriceSum;
    if (totalPriceSum > 0 && totalDiscountedPriceSum > 0) {
      discount =
          (((totalPriceSum - totalDiscountedPriceSum) / totalPriceSum) * 100)
              .toInt();
    }

    print(totalDiscountedPriceSum);
    notifyListeners();
    return "";
  }
}
