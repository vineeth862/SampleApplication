class address {
  String? fullAddress;
  String? pincode;
  String? floorNumber;
  String? houseNumber;

  address({
    this.fullAddress,
    this.pincode,
    this.floorNumber,
    this.houseNumber,
  });
  toJson() {
    return {
      "fullAddress": fullAddress,
      "pincode": pincode,
      "floorNumber": floorNumber,
      "houseNumber": houseNumber,
    };
  }
}
