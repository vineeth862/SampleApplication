class userModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNo;

  const userModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.phoneNo,
  });
  toJson() {
    return {
      "FullName": fullname,
      "Email": email,
      "phone": phoneNo,
    };
  }
}
