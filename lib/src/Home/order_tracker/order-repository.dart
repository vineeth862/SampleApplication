import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import '../models/order/order.dart' as orderModule;

class OrderRepository extends GetxController {
  List<orderModule.Order> orderList = [];

  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  GlobalService globalservice = GlobalService();

  fetchAllOrders(List orderIds, from) async {
    orderList = [];

    if (orderIds.length > 0) {
      List<dynamic> batches = [];
      for (int i = 0; i < orderIds.length; i += 10) {
        try {
          batches.add(orderIds.sublist(i, i + 10));
        } catch (e) {
          batches.add(orderIds.sublist(i, orderIds.length));
        }
      }

      if (from == "cart") {
        for (var batch in batches) {
          final orders = await _db
              .collection("order")
              .where("orderNumber", whereIn: batch)
              .get();

          if (orders.docs.isNotEmpty) {
            orders.docs.map((doc) {
              return orderModule.Order.fromJson(doc.data());
            }).forEach((orderModule.Order element) {
              if (element.statusCode == 1) {
                orderList.add(element);
              }
            });
          }
        }
      } else {
        for (var batch in batches) {
          final orders = await _db
              .collection("order")
              .where("orderNumber", whereIn: batch)
              .get();
          if (orders.docs.isNotEmpty) {
            orders.docs.map((doc) {
              return orderModule.Order.fromJson(doc.data());
            }).forEach((orderModule.Order element) {
              if (element.statusCode != 1) {
                orderList.add(element);
              }
            });
          }
        }
      }
    }
    // notifyListeners();
    return "";
  }
}
