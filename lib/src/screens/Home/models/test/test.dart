class Test {
  String frequency;
  String hf_test_code;
  String labCode;
  String labName;
  String method;
  String price;
  String sampleContainer;
  String sampletypename;
  String tat;
  String testProcessingDays;
  String test_code;
  String test_des;
  String testname;

  Test(
      {required this.frequency,
      required this.hf_test_code,
      required this.labCode,
      required this.labName,
      required this.method,
      required this.price,
      required this.sampleContainer,
      required this.sampletypename,
      required this.tat,
      required this.testProcessingDays,
      required this.test_code,
      required this.test_des,
      required this.testname});
  toJson() {
    return {
      "frequency": frequency,
      "hf_test_code": hf_test_code,
      "labCode": labCode,
      "labName": labName,
      "method": method,
      "price": price,
      "sampleContainer": sampleContainer,
      "sampletypename": sampletypename,
      "tat": tat,
      "testProcessingDays": testProcessingDays,
      "test_code": test_code,
      "test_des": test_des,
      "testname": testname
    };
  }
}
