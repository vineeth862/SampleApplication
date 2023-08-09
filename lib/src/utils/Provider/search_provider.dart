import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab_card.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/models/test/test_card.dart';

import '../../screens/Home/models/lab/branchDetails.dart';

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
    // final _db = FirebaseFirestore.instance;
    var testList = await FirebaseFirestore.instance
        .collection('test')
        .where('testname', isGreaterThanOrEqualTo: value.toUpperCase())
        .where('testname', isLessThanOrEqualTo: value.toUpperCase() + '\uf8ff')
        .get();

    var labList = await FirebaseFirestore.instance
        .collection('lab')
        .where('labName', isGreaterThanOrEqualTo: value)
        .where('labName', isLessThanOrEqualTo: value + '\uf8ff')
        .get();

    if (testList.docs.isNotEmpty) {
      filteredTests = testList.docs.map((doc) {
        return testObjectConverter(doc);
      }).toList();
    }

    // // here we are filtering labs based on the input value and assigned to the filteredLabs.
    if (labList.docs.isNotEmpty) {
      filteredLabs = labList.docs.map((doc) {
        return labObjectConverter(doc);
      }).toList();
    }
    // filteredLabs = labList
    //     .where((element) => element.name.trim().contains(value.trim()))
    //     .toList();
    // // here we are filtering labs based on the input value and assigned to the filtered tests.

    notifyListeners();
    return "";
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

  Lab labObjectConverter(lab) {
    return Lab(
        labName: lab['labName'].toString(),
        branchDetails: branchDetailsObjectConverter(lab['branchDetails']),
        test: [...lab['test']]);
  }

  List<BranchDetails> branchDetailsObjectConverter(List obj) {
    List<BranchDetails> list = [];
    obj.forEach((e) {
      list.add(BranchDetails(
          availablePincodeDetails: [...e['availablePincodeDetails']],
          fullAddress: e['fullAddress'],
          locality: e['locality'],
          pincode: e['pincode']));
    });
    return list;
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
