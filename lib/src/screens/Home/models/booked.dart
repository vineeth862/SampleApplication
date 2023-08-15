class Booked {
  String? bookedDate;
  String? bookedSlot;
  String? slot;
  Booked(
      {required this.bookedDate, required this.bookedSlot, required this.slot});

  toJson() {
    return {
      "bookedDate": bookedDate,
      "bookedSlot": bookedSlot,
      "slot": slot,
    };
  }
}
