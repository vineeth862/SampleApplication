import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab_card.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/models/test/test_card.dart';

class SearchListState with ChangeNotifier {
  List<Lab> filteredLabs = [];
  List<Test> filteredTests = [];

  List<Test> get gettestSuggetionList {
    return filteredTests;
  }

  List<Lab> get getlabSuggetionList {
    return filteredLabs;
  }

  void search(String value) async {
    filteredTests = [];
    filteredLabs = [];
    // final _db = FirebaseFirestore.instance;
    var result = await FirebaseFirestore.instance
        .collection('test')
        .where('testname', isGreaterThanOrEqualTo: value.toUpperCase())
        .where('testname', isLessThanOrEqualTo: value.toUpperCase() + 'z')
        .get();
    if (result.docs.isNotEmpty) {
      filteredTests = result.docs.map((doc) {
        return testObjectConverter(doc);
      }).toList();
    }
    // // here we are filtering labs based on the input value and assigned to the filteredLabs.
    // filteredLabs = labList
    //     .where((element) => element.name.trim().contains(value.trim()))
    //     .toList();
    // // here we are filtering labs based on the input value and assigned to the filtered tests.

    notifyListeners();
  }

  List<LabCard> filteredLabCardList = [];

  List<TestCard> filteredTestCardList = [];

  List<LabCard> get getLabCardList {
    return filteredLabCardList;
  }

  set setLabCardList(value) {
    // here filtering all lab based on the test
    // filteredLabCardList = labList
    //     .where((element) {
    //       return element.test.contains(value.toString());
    //     })
    //     .map((e) => LabCard(name: e.name, test: value, testCode: e.testCode))
    //     .toList();
  }

  List<TestCard> get getTestCardList {
    return filteredTestCardList;
  }

  setTestCardList(testCode) async {
    var result = await FirebaseFirestore.instance
        .collection('test')
        .where('hf_test_code', isEqualTo: testCode)
        .get();
    if (result.docs.isNotEmpty) {
      // Lab cardObject = result.docs.where((element) {
      //   return element.name.toString() == value.toString();
      // }).elementAt(0);
      filteredTestCardList = result.docs
          .map((e) => TestCard(
              name: e.data()?['testname'],
              test: e.data()?['tat'],
              testSelcted: false,
              testCode: e.data()?['hf_test_code'],
              price: e.data()['price'].toString(),
              testObject: testObjectConverter(e)))
          .toList();
    }
    notifyListeners();
    // here choosing all the test in perticular lab
    // List list = labList.where((element) {
    //   return element.name.toString() == value.toString();
    // }).toList();

    // if (list.isNotEmpty) {
    //   Lab cardObject = labList.where((element) {
    //     return element.name.toString() == value.toString();
    //   }).elementAt(0);
    //   filteredTestCardList = cardObject.test
    //       .map((e) => TestCard(
    //           name: value,
    //           test: e.toString(),
    //           testSelcted: false,
    //           testCode: cardObject.testCode))
    //       .toList();
    // }
  }

  cardClicked(code) {
    filteredTestCardList = [];
    filteredLabCardList = [];

    // setLabCardList = labCode;
    setTestCardList(code);
    return;
  }

  Test testObjectConverter(test) {
    return Test(
      frequency: test['frequency'].toString(),
      hf_test_code: test['hf_test_code'].toString(),
      labCode: test['labCode'].toString(),
      labName: test['labCode'].toString(),
      method: test['method'].toString(),
      price: test['price'].toString(),
      sampleContainer: test['sampleContainer'].toString(),
      sampletypename: test['sampletypename'].toString(),
      tat: test['tat'].toString(),
      testProcessingDays: test['testProcessingDays'].toString(),
      test_code: test['test_code'].toString(),
      test_des: test['test_des'].toString(),
      testname: test['testname'].toString(),
    );
  }
}
