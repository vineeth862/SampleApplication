class LabCard {
  final String name;
  final String test;
  final String testCode;
  final String labCode;
  final String location;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test, $testCode , labCode: $labCode}';
  }

  LabCard(
      {required this.name,
      required this.test,
      required this.testCode,
      required this.labCode,
      required this.location});
}
