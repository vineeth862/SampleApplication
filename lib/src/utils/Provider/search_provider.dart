import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab.dart';
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
    // filteredLabs = [];
    if (value.isNotEmpty) {
      // final _db = FirebaseFirestore.instance;
      var testList = await FirebaseFirestore.instance
          .collection('test')
          .where('testname', isGreaterThanOrEqualTo: value.toUpperCase())
          .where('testname',
              isLessThanOrEqualTo: value.toUpperCase() + '\uf8ff')
          .get();

      var labList = await FirebaseFirestore.instance.collection('lab').get();

      if (testList.docs.isNotEmpty) {
        filteredTests = testList.docs.map((doc) {
          return testObjectConverter(doc);
        }).toList();
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
          return labObjectConverter(doc);
        }).toList();
      }
      // filteredLabs = labList
      //     .where((element) => element.name.trim().contains(value.trim()))
      //     .toList();
      // // here we are filtering labs based on the input value and assigned to the filtered tests.
    }
    notifyListeners();
    return "";
  }

  searchTest(String value, String labCode) async {
    filteredTestCardList = [];
    var result = await FirebaseFirestore.instance
        .collection('test')
        .where("labCode", isEqualTo: labCode)
        .where('testname', isGreaterThanOrEqualTo: value.toUpperCase())
        .where('testname', isLessThanOrEqualTo: value.toUpperCase() + '\uf8ff')
        .get();
    if (result.docs.isNotEmpty) {
      filteredTestCardList = result.docs
          .map((e) => TestCard(
              name: e.data()['testname'],
              test: e.data()['tat'],
              testSelcted: false,
              labName: e.data()['labName'],
              testCode: e.data()['hf_test_code'],
              price: e.data()['price'].toString(),
              testObject: testObjectConverter(e)))
          .toList();
    }
    notifyListeners();
    return "";
  }

  // List<LabCard> filteredLabCardList = [];

  List<TestCard> filteredTestCardList = [];

  // List<LabCard> get getLabCardList {
  //   return filteredLabCardList;
  // }

  setLabCardList(labCode) async {
    var result = await FirebaseFirestore.instance
        .collection('lab')
        .where('labName', isEqualTo: labCode)
        .get();
    if (result.docs.isNotEmpty) {
      // Lab cardObject = result.docs.where((element) {
      //   return element.name.toString() == value.toString();
      // }).elementAt(0);
      filteredTestCardList = result.docs
          .map((e) => TestCard(
              name: e.data()['testname'],
              test: e.data()['tat'],
              testSelcted: false,
              labName: e.data()['labName'],
              testCode: e.data()['hf_test_code'],
              price: e.data()['price'].toString(),
              testObject: testObjectConverter(e)))
          .toList();
    }
    notifyListeners();
  }

  List<TestCard> get getTestCardList {
    return filteredTestCardList;
  }

  setTestCardList(testCode, condition) async {
    var result = await FirebaseFirestore.instance
        .collection('test')
        .where(condition, isEqualTo: testCode)
        .get();
    if (result.docs.isNotEmpty) {
      filteredTestCardList = result.docs
          .map((e) => TestCard(
              name: e.data()['testname'],
              test: e.data()['tat'],
              testSelcted: false,
              testCode: e.data()['hf_test_code'],
              price: e.data()['price'].toString(),
              labName: e.data()['labName'],
              testObject: testObjectConverter(e)))
          .toList();
    }
    notifyListeners();
  }

  cardClicked(String code, bool test) {
    filteredTestCardList = [];
    // filteredLabCardList = [];

    if (test) {
      setTestCardList(code, 'hf_test_code');
    } else {
      setTestCardList(code, 'labCode');
      // setLabCardList(code);
    }

    return;
  }

  Lab labObjectConverter(lab) {
    return Lab(
        labName: lab['labName'].toString(),
        branchDetails: branchDetailsObjectConverter(lab['branchDetails']),
        test: [...lab['test']],
        hf_lab_code: lab['hf_lab_code']);
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
      labName: test['labName'].toString(),
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
