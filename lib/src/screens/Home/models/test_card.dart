class TestCard {
  final String name;
  final String test;

  @override
  String toString() {
    return 'TestCard{name: $name,test: $test}';
  }

  TestCard({required this.name, required this.test});
}
