import 'package:flutter/material.dart';

import '../../screens/Home/models/order/order.dart';

class SelectedOrderState extends ChangeNotifier {
  Order order = Order();
  Order? orderDetails;
  get getOrder {
    return order;
  }

  set setOrder(Order order) {
    this.order = order;
  }

  void resetOrder() {
    order = Order();
  }

  Future<void> fetchOrderDetails() async {
    // Simulate fetching order details from backend
    await Future.delayed(Duration(seconds: 2));

    orderDetails = order; // Replace with actual data
    //notifyListeners();
  }
}
