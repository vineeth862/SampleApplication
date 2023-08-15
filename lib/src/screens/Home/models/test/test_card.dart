import 'package:sample_application/src/screens/Home/models/test/test.dart';

class TestCard {
  final String name;
  final String test;
  final bool testSelcted;
  final String testCode;
  final String price;
  final String labName;
  final Test testObject;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test,testSelected: $testSelcted, testCode:$testCode, price:$price , labName:$labName}';
  }

  TestCard(
      {required this.name,
      required this.test,
      required this.testSelcted,
      required this.testCode,
      required this.price,
      required this.labName,
      required this.testObject});
}
