class Users {
  String? uId;
  String? userName;
  List<String>? location;
  String? mobile;
  String? email;
  List<String>? orders;

  Users(
      {this.uId,
      this.userName,
      this.email,
      this.mobile,
      this.location,
      this.orders});
  toJson() {
    return {
      "userName": userName,
      "email": email,
      "mobile": mobile,
      "uId": uId,
      "location": location,
      "orders": orders
    };
  }
}
