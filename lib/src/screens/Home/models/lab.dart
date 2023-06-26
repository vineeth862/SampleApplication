import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Lab {
  final String name;
  final List<String> test;

  @override
  String toString() {
    return 'Lab{name: $name, test: $test}';
  }

  Lab({required this.name, required this.test});
}
