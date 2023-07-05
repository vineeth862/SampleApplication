import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/lab.dart';

class SearchListState with ChangeNotifier {
  List<Lab> labList = [
    Lab(name: "lab1", test: ["test1", "test2", "test3", "test4"]),
    Lab(name: "lab2", test: ["test12", "test2", "test4"]),
    Lab(name: "lab3", test: ["test1", "test2", "test3", "test5"]),
    Lab(name: "lab4", test: ["test1", "test7", "test3", "test4"]),
    Lab(name: "lab5", test: ["test12", "test2", "test3", "test4"]),
    Lab(name: "lab6", test: ["test1", "test4"]),
    Lab(name: "lab7", test: ["test1", "test2", "test3", "test4"]),
    Lab(name: "lab8", test: ["test0", "test2", "test3", "test4"]),
    Lab(name: "lab9", test: ["test1", "test2", "test3", "test8"]),
  ];
  List<Lab> filteredLabs = [];
  late Set<String> filteredTests = {};

  Set<String> get gettestList {
    return filteredTests;
  }

  List<Lab> get getlabList {
    return filteredLabs;
  }

  void search(value) {
    filteredTests = {};
    filteredLabs = [];

    // here we are filtering labs based on the input value and assigned to the filteredLabs.
    filteredLabs = labList
        .where((element) => element.name.trim().contains(value.trim()))
        .toList();
    // here we are filtering labs based on the input value and assigned to the filtered tests.
    labList.forEach((element) => element.test.forEach((element) => {
          if (element.toString().contains(value.trim().toString()))
            {filteredTests.add(element)}
        }));

    notifyListeners();
  }
}
