class Users {
  String? uId;
  String? userName;
  List<String>? location;
  String? mobile;
  String? email;
  List<String>? orders;
  String? created;
  String? lastSignedIn;

  Users(
      {this.uId,
      this.userName,
      this.email,
      this.mobile,
      this.location,
      this.orders,
      this.created,
      this.lastSignedIn});
  toJson() {
    return {
      "userName": userName,
      "email": email,
      "mobile": mobile,
      "uId": uId,
      "location": location,
      "orders": orders,
      "created": created,
      "lastSignedIn": lastSignedIn
    };
  }
}
