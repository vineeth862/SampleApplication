import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/screens/Home/models/lab/lab.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/models/test/testcard.dart';
import '../../global_service/user_location.dart';

class SearchListState with ChangeNotifier {
  List<Lab> filteredLabs = [];
  List<Test> filteredTests = [];
  var filteredMaleCategory = [];
  List<String> filteredFemaleCategory = [];
  final myController = Get.find<UserCurrentLocation>();
  String input = '';

  List<Test> get gettestSuggetionList {
    return filteredTests;
  }

  void resetSearchList() {
    filteredTests = [];
    filteredLabs = [];
    notifyListeners();
  }

  List<Lab> get getlabSuggetionList {
    return filteredLabs;
  }

  searchLab(value, pinCode) async {
    var labList = await FirebaseFirestore.instance.collection('lab').get();

    // here we are filtering labs based on the input value and assigned to the filteredLabs.
    if (labList.docs.isNotEmpty) {
      return labList.docs.map((doc) {
        return Lab.fromJson(doc.data());
      }).where((element) {
        return element.labName
                .toLowerCase()
                .contains(value.toString().toLowerCase()) &&
            element.branchDetails
                .where((element) => element.availablePincodeDetails
                    .contains(pinCode.toString()))
                .isNotEmpty;
      }).toList();
    }
    return [];
  }

  search(String value) async {
    filteredTests = [];
    filteredLabs = [];
    input = value;
    if (value.isNotEmpty) {
      filteredLabs = await searchLab(value, myController.pinCode);
      var testList = await FirebaseFirestore.instance
          .collection('test2')
          .where(
            'displayName',
            isGreaterThanOrEqualTo: value.toUpperCase(),
          )
          .where('displayName',
              isLessThanOrEqualTo: '${value.toUpperCase()}\uf8ff')
          .get();

      if (testList.docs.isNotEmpty) {
        for (var test in testList.docs) {
          var filteredTest = filteredTests
              .where((element) =>
                  element.displayName == Test.fromJson(test.data()).displayName)
              .toList();
          bool flag = false;
          // ignore: iterable_contains_unrelated_type
          myController.availabelLabs.forEach((element) {
            if (!flag)
              flag = (element.labCode.toString() == test.data()['labCode']);
          });
          if (filteredTest.isEmpty && flag) {
            filteredTests.add(Test.fromJson(test.data()));
          }
        }
      }
    }

    notifyListeners();
    return "";
  }

  searchTestByLabCode(String value, String labCode) async {
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
      filteredTestCardList = [];
      for (var test in result.docs) {
        bool flag = false;
        myController.availabelLabs.forEach((element) {
          if (!flag)
            flag = (element.labCode.toString() == test.data()['labCode']);
        });
        if (flag) {
          if (uniqueTets.add(TestCard.fromJson(test.data()).name)) {
            filteredTestCardList.add(TestCard.fromJson(test.data()));
          }
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
          result.docs.map((e) => TestCard.fromJson(e.data())).where((test) {
        bool flag = false;
        myController.availabelLabs.forEach((element) {
          if (!flag)
            flag = (element.labCode.toString() == test.testObject.labCode);
        });
        return flag;
      }).toList();
    }
    notifyListeners();
  }

  searchPriorityTestAndLabs() async {
    input = '';
    var testList = await FirebaseFirestore.instance
        .collection('priorityTest')
        // .where("priority", isEqualTo: true)
        // .orderBy('priorityOrder')
        .get();

    var labList = await FirebaseFirestore.instance
        .collection('lab')
        // .where("priority", isEqualTo: true)
        // .orderBy('priorityOrder')
        .get();

    if (testList.docs.isNotEmpty) {
      filteredTests = testList.docs.map((doc) {
        return Test.fromJson(doc.data());
      }).where((test) {
        bool flag = false;
        myController.availabelLabs.forEach((element) {
          if (!flag) flag = (element.labCode.toString() == test.labCode);
        });
        return flag;
      }).toList();
    }

    if (labList.docs.isNotEmpty) {
      // print(labList.docs.map((e) => print(e.data())));
      filteredLabs = labList.docs.map((doc) {
        return Lab.fromJson(doc.data());
      }).where((element) {
        return element.branchDetails
            .where((element) => element.availablePincodeDetails
                .contains(myController.pinCode.toString()))
            .isNotEmpty;
      }).toList();
    }

    notifyListeners();
    return "";
  }

// card related operations

  cardClicked(String code, bool test) {
    filteredTestCardList = [];
    if (test) {
      setTestCardList(code, 'medCapTestCode');
    } else {
      setTestCardList(code, 'labCode');
    }

    return;
  }

  categoryClicked(String category, String param) {
    filteredTestCardList = [];

    setTestCardList(param, category);

    return;
  }

  filterLabOnPinCode() async {
    var labList = await FirebaseFirestore.instance.collection('lab').get();
    myController.availabelLabs = labList.docs.map((doc) {
      return Lab.fromJson(doc.data());
    }).where((element) {
      return element.branchDetails
          .where((element) => element.availablePincodeDetails
              .contains(myController.pinCode.toString()))
          .isNotEmpty;
    }).toList();
  }

  List get gettestCategoryMaleList {
    return filteredMaleCategory;
  }

  List<String> get gettestCategoryfemaleList {
    return filteredFemaleCategory;
  }

  List<TestCard> get getFilteredMaleCardList {
    return filteredMaleCardList;
  }

  List<TestCard> filteredMaleCardList = [];
  setFilteredMaleCardList(testCode, condition) async {
    var result = await FirebaseFirestore.instance
        .collection('test2')
        .where(condition, isEqualTo: testCode)
        .get();
    if (result.docs.isNotEmpty) {
      filteredMaleCardList =
          result.docs.map((e) => TestCard.fromJson(e.data())).where((test) {
        bool flag = false;
        myController.availabelLabs.forEach((element) {
          if (!flag)
            flag = (element.labCode.toString() == test.testObject.labCode);
        });
        return flag;
      }).toList();
    }
    notifyListeners();
  }
}
