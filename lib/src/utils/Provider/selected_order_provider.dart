import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/user_repository.dart';

import '../../screens/Home/models/order/order.dart' as orders;

class SelectedOrderState extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  orders.Order order = orders.Order();
  static DocumentReference<Map<String, dynamic>>? document;
  get getOrder {
    return order;
  }

  set setOrder(orders.Order order) {
    this.order = order;
  }

  void resetOrder() {
    order = orders.Order();
    notifyListeners();
  }

  Future<bool> docInIt() async {
    document = await _db.collection("order").doc();
    order.orderNumber = document!.id;
    notifyListeners();
    return true;
  }

  Future<bool> createOrder() async {
    UserRepository().addOrderIdsToUser(document?.id);
    await _db
        .collection("order")
        .doc(document?.id)
        .set(order.toJson())
        .whenComplete(() => print("succes"))
        .catchError((error, stackTrace) {
      print("Something went wrong");
    });
    notifyListeners();
    return true;
  }

  fetchAllOrders(List orderIds) async {
    final ordersList = await _db
        .collection("order")
        .where("orderNumber", whereIn: orderIds)
        .get();

    if (ordersList.docs.isNotEmpty) {
      return ordersList.docs.map((doc) {
        return orders.Order.fromJson(doc.data());
      }).toList();
    }
    return [];
  }
}
