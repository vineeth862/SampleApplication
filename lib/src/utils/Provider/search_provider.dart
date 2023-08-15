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

    if (value.isNotEmpty) {
      var testList = await FirebaseFirestore.instance
          .collection('test')
          .where('testname', isGreaterThanOrEqualTo: value.toUpperCase())
          .where('testname',
              isLessThanOrEqualTo: value.toUpperCase() + '\uf8ff')
          .get();

      var labList = await FirebaseFirestore.instance.collection('lab').get();

      if (testList.docs.isNotEmpty) {
        filteredTests = testList.docs.map((e) {
          return Test.fromJson(e.data() as Map<String, dynamic>);
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
        .collection('test')
        .where("labCode", isEqualTo: labCode)
        .where('testname', isGreaterThanOrEqualTo: value.toUpperCase())
        .where('testname', isLessThanOrEqualTo: value.toUpperCase() + '\uf8ff')
        .get();
    if (result.docs.isNotEmpty) {
      filteredTestCardList =
          result.docs.map((e) => TestCard.fromJson(e.data())).toList();
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
        .collection('test')
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
      setTestCardList(code, 'hf_test_code');
    } else {
      setTestCardList(code, 'labCode');
    }

    return;
  }

  // Lab labObjectConverter(lab) {
  //   return Lab(
  //       labName: lab['labName'].toString(),
  //       branchDetails: branchDetailsObjectConverter(lab['branchDetails']),
  //       test: [...lab['test']],
  //       hf_lab_code: lab['hf_lab_code']);
  // }

  // List<BranchDetails> branchDetailsObjectConverter(List obj) {
  //   List<BranchDetails> list = [];
  //   obj.forEach((e) {
  //     list.add(BranchDetails(
  //         availablePincodeDetails: [...e['availablePincodeDetails']],
  //         fullAddress: e['fullAddress'],
  //         locality: e['locality'],
  //         pincode: e['pincode']));
  //   });
  //   return list;
  // }
}
