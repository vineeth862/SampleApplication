import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab_card.dart';
import 'package:sample_application/src/screens/Home/models/test/test_card.dart';

class SearchListState with ChangeNotifier {
  List<Lab> labList = [
    Lab(
        name: "lab1",
        test: ["test1", "test2", "test3", "test4"],
        sample: [],
        tat: "",
        testCode: "01",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab2",
        test: ["test12", "test2", "test4"],
        sample: [],
        tat: "",
        testCode: "02",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab3",
        test: ["test1", "test2", "test3", "test5"],
        sample: [],
        tat: "",
        testCode: "03",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab4",
        test: ["test1", "test7", "test3", "test4"],
        sample: [],
        tat: "",
        testCode: "04",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab5",
        test: ["test12", "test2", "test3", "test4"],
        sample: [],
        tat: "",
        testCode: "05",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab6",
        test: ["test1", "test4"],
        sample: [],
        tat: "",
        testCode: "06",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab7",
        test: ["test1", "test2", "test3", "test4"],
        sample: [],
        tat: "",
        testCode: "07",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab8",
        test: ["test0", "test2", "test3", "test4"],
        sample: [],
        tat: "",
        testCode: "08",
        preperation: [],
        suggestionTest: []),
    Lab(
        name: "lab9",
        test: ["test1", "test2", "test3", "test8"],
        sample: [],
        tat: "",
        testCode: "09",
        preperation: [],
        suggestionTest: []),
  ];
  List<Lab> filteredLabs = [];
  late Set<String> filteredTests = {};

  Set<String> get gettestSuggetionList {
    return filteredTests;
  }

  List<Lab> get getlabSuggetionList {
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

  List<LabCard> filteredLabCardList = [];

  List<TestCard> filteredTestCardList = [];

  List<LabCard> get getLabCardList {
    return filteredLabCardList;
  }

  set setLabCardList(value) {
    // here filtering all lab based on the test
    filteredLabCardList = labList
        .where((element) {
          return element.test.contains(value.toString());
        })
        .map((e) => LabCard(name: e.name, test: value, testCode: e.testCode))
        .toList();
  }

  List<TestCard> get getTestCardList {
    return filteredTestCardList;
  }

  set setTestCardList(value) {
    // here choosing all the test in perticular lab
    List list = labList.where((element) {
      return element.name.toString() == value.toString();
    }).toList();

    if (list.isNotEmpty) {
      filteredTestCardList = labList
          .where((element) {
            return element.name.toString() == value.toString();
          })
          .elementAt(0)
          .test
          .map((e) =>
              TestCard(name: value, test: e.toString(), testSelcted: false))
          .toList();
    }
  }

  cardClicked(value) {
    filteredTestCardList = [];
    filteredLabCardList = [];

    setLabCardList = value;
    setTestCardList = value;
    notifyListeners();
    return;
  }
}
