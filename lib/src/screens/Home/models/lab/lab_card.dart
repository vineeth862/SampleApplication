class LabCard {
  final String name;
  final String test;
  final String testCode;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test}';
  }

  LabCard({required this.name, required this.test, required this.testCode});
}
