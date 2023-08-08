import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String _globalString = 'Initial Value';

  String get globalString => _globalString;

  void updateGlobalString(String newValue) {
    _globalString = newValue;
    notifyListeners();
  }
}
