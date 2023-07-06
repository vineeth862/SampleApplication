class LabCard {
  final String name;
  final String test;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test}';
  }

  LabCard({required this.name, required this.test});
}
