import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/user_repository.dart';

import '../../screens/Home/models/order/order.dart' as orderModule;
import '../../screens/Home/models/status/status.dart';

class SelectedOrderState extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  orderModule.Order order = orderModule.Order();
  Status status = Status();
  static DocumentReference<Map<String, dynamic>>? document;
  get getOrder {
    return order;
  }

  get getStatus {
    return status;
  }

  set setOrder(orderModule.Order order) {
    this.order = order;
  }

  void resetOrder() {
    order = orderModule.Order();
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

  Future<String> fetchStatus(statusCode) async {
    final statusObj = await _db
        .collection("masterData")
        .where("statusCode", isEqualTo: statusCode)
        .get();
    status = Status.fromJson(statusObj.docs.first.data());
    return "";
  }
}
