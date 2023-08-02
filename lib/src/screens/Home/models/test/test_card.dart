class TestCard {
  final String name;
  final String test;
  final bool testSelcted;
  final String testCode;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test,testSelected: $testSelcted, testCode:$testCode}';
  }

  TestCard(
      {required this.name,
      required this.test,
      required this.testSelcted,
      required this.testCode});
}
