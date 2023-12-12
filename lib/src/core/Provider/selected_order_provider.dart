import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/core/globalServices/authentication/user_repository.dart';

import '../../Home/models/order/order.dart' as orderModule;
import '../../Home/models/status/status.dart';

class SelectedOrderState extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  orderModule.Order order = orderModule.Order();
  Status status = Status();
  static dynamic document;
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
    var document = await _db
        .collection("order")
        .orderBy('createdDate', descending: true)
        .limit(1)
        .get();

    if (document.size > 0) {
      var id = document.docs[0].id;
      List<String> result = id.split(RegExp(r'(?<=\D)(?=\d)|(?<=\d)(?=\D)'));
      order.orderNumber = result[0] + (int.parse(result[1]) + 1).toString();
    } else {
      order.orderNumber = 'MCHID1';
    }
    notifyListeners();
    return true;
  }

  Future<bool> createOrder() async {
    dynamic documentSnapshot = await FirebaseFirestore.instance
        .collection("order")
        .doc(order.orderNumber)
        .get();

    print(documentSnapshot.data()?['orderNumber']);
    print(order.orderNumber);

    if (!documentSnapshot.exists ||
        documentSnapshot.data()?['orderNumber'] == order.orderNumber) {
      await _db
          .collection("order")
          .doc(order.orderNumber)
          .set(order.toJson())
          .whenComplete(() =>
              {UserRepository().addOrderIdsToUser(order.orderNumber, true)})
          .catchError((error, stackTrace) {
        print("Something went wrong");
      });
    } else {
      var id = documentSnapshot.id;
      List<String> result = id.split(RegExp(r'(?<=\D)(?=\d)|(?<=\d)(?=\D)'));
      order.orderNumber = result[0] + (int.parse(result[1]) + 1).toString();
      order.createdDate = new DateTime.now().toString();
      await _db
          .collection("order")
          .doc(order.orderNumber)
          .set(order.toJson())
          .whenComplete(() =>
              {UserRepository().addOrderIdsToUser(order.orderNumber, true)})
          .catchError((error, stackTrace) {
        print("Something went wrong");
      });
    }

    notifyListeners();
    return true;
  }

  removeOrder(orderNumber) async {
    await _db.collection("order").doc(orderNumber).delete();
    UserRepository().addOrderIdsToUser(order.orderNumber, false);
  }

  Future<String> fetchStatus(statusCode) async {
    final statusObj = await _db
        .collection("masterData")
        .where("statusCode", isEqualTo: statusCode)
        .get();
    status = Status.fromJson(statusObj.docs.first.data());
    return "";
  }

  Future<String> isPinCodeValid(statusCode) async {
    final statusObj = await _db
        .collection("lab")
        .where("statusCode", isEqualTo: statusCode)
        .get();
    status = Status.fromJson(statusObj.docs.first.data());
    return "";
  }
}
