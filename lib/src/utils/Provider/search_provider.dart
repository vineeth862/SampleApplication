import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/models/test/testcard.dart';

class SearchListState with ChangeNotifier {
  List<Lab> filteredLabs = [];
  List<Test> filteredTests = [];

  List<Test> get gettestSuggetionList {
    return filteredTests;
  }

  List<Lab> get getlabSuggetionList {
    return filteredLabs;
  }

  search(String value) async {
    filteredTests = [];
    filteredLabs = [];
    if (value.isNotEmpty) {
      var testList = await FirebaseFirestore.instance
          .collection('test2')
          .where('displayName', isGreaterThanOrEqualTo: value.toUpperCase())
          .where('displayName',
              isLessThanOrEqualTo: '${value.toUpperCase()}\uf8ff')
          .get();

      var labList = await FirebaseFirestore.instance.collection('lab').get();
      if (testList.docs.isNotEmpty) {
        Set<String> uniqueTets = Set();

        for (var test in testList.docs) {
          if (uniqueTets.add(Test.fromJson(test.data()).displayName)) {
            filteredTests.add(Test.fromJson(test.data()));
          }
        }
      }

      // here we are filtering labs based on the input value and assigned to the filteredLabs.
      if (labList.docs.isNotEmpty) {
        filteredLabs = labList.docs.where((element) {
          return element
              .data()['labName']
              .toString()
              .toLowerCase()
              .contains(value.toString().toLowerCase());
        }).map((doc) {
          return Lab.fromJson(doc.data());
        }).toList();
      }
    }
    notifyListeners();
    return "";
  }

  searchTest(String value, String labCode) async {
    filteredTestCardList = [];
    var result = await FirebaseFirestore.instance
        .collection('test2')
        .where("labCode", isEqualTo: labCode)
        .where('displayName', isGreaterThanOrEqualTo: value.toUpperCase())
        .where('displayName',
            isLessThanOrEqualTo: value.toUpperCase() + '\uf8ff')
        .get();
    if (result.docs.isNotEmpty) {
      Set<String> uniqueTets = Set();

      for (var test in result.docs) {
        if (uniqueTets.add(TestCard.fromJson(test.data()).name)) {
          filteredTestCardList.add(TestCard.fromJson(test.data()));
        }
      }
    }
    notifyListeners();
    return "";
  }

  List<TestCard> filteredTestCardList = [];

  setLabCardList(labCode) async {
    var result = await FirebaseFirestore.instance
        .collection('lab')
        .where('labName', isEqualTo: labCode)
        .get();
    if (result.docs.isNotEmpty) {
      filteredTestCardList =
          result.docs.map((e) => TestCard.fromJson(e.data())).toList();
    }
    notifyListeners();
  }

  List<TestCard> get getTestCardList {
    return filteredTestCardList;
  }

  setTestCardList(testCode, condition) async {
    var result = await FirebaseFirestore.instance
        .collection('test2')
        .where(condition, isEqualTo: testCode)
        .get();
    if (result.docs.isNotEmpty) {
      filteredTestCardList =
          result.docs.map((e) => TestCard.fromJson(e.data())).toList();
    }
    notifyListeners();
  }

  cardClicked(String code, bool test) {
    filteredTestCardList = [];

    if (test) {
      setTestCardList(code, 'medCapTestCode');
    } else {
      setTestCardList(code, 'labCode');
    }

    return;
  }
}
