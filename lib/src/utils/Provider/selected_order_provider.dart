import 'package:flutter/material.dart';

import '../../screens/Home/models/order/order.dart';

class SelectedOrderState extends ChangeNotifier {
  Order order = Order();

  get getOrder {
    return order;
  }

  set setOrder(Order order) {
    this.order = order;
  }

  void resetOrder() {
    order = Order();
  }
}
