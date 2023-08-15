class User {
  String? uId;
  String? userName;
  List<String>? location;
  String? mobile;
  String? email;
  List<String>? orders;
  String? created;
  String? lastSignedIn;
  String? age;
  String? gender;

  User(
      {this.uId,
      this.userName,
      this.email,
      this.mobile,
      this.location,
      this.orders,
      this.created,
      this.lastSignedIn,
      this.age,
      this.gender});
  toJson() {
    return {
      "userName": userName,
      "email": email,
      "mobile": mobile,
      "uId": uId,
      "location": location,
      "orders": orders,
      "created": created,
      "age": age,
      "lastSignedIn": lastSignedIn,
      "gender": gender
    };
  }
}
