import 'package:flutter/material.dart';

class SelectedTestState with ChangeNotifier {
  final List<String> selectedTest = [];

  List<String> get getSelectedTest {
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
}
