import 'package:flutter/material.dart';

import '../../screens/Home/models/test/test.dart';

class SelectedTestState with ChangeNotifier {
  final List<Test> selectedTest = [];
  bool _detailExpanded = false;

  List<Test> get getSelectedTest {
    return selectedTest;
  }

  void addTest(test) {
    selectedTest.add(test);
    notifyListeners();
  }

  void removeTest(test) {
    selectedTest.remove(test);
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
  }
}
