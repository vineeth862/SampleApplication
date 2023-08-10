import 'branchDetails.dart';

class Lab {
  late String labName;

  List<String> test;

  String hf_lab_code;

  List<BranchDetails> branchDetails;

  Lab(
      {required this.branchDetails,
      required this.test,
      required this.labName,
      required this.hf_lab_code});
}
