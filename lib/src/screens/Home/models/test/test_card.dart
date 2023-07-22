class TestCard {
  final String name;
  final String test;
  final bool testSelcted;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test,testSelected: $testSelcted}';
  }

  TestCard({required this.name, required this.test, required this.testSelcted});
}
