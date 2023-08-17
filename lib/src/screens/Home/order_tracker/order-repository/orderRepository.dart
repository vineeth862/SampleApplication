import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart'
    as order;

class OrderRepository {
  final _db = FirebaseFirestore.instance;
  static OrderRepository get instance => Get.find();
  Future<String> createOrder(order.Order order) async {
    final doc = await _db.collection("order").doc();
    order.statusLabel = "Payment Pending";
    order.statusCode = 1;
    if (order.orderNumber == null) {
      order.orderNumber = doc.id;
      await UserRepository().addOrderIdsToUser(doc.id);
      await doc
          .set(order.toJson())
          .whenComplete(() => print("succes"))
          .catchError((error, stackTrace) {
        print("Something went wrong");
        // print(_db.collection('user').snapshots().length.toString());
      });
      return doc.id;
    } else {
      await _db
          .collection("order")
          .doc(order.orderNumber)
          .set(order.toJson())
          .whenComplete(() => print("succes"))
          .catchError((error, stackTrace) {
        print("Something went wrong");
        // print(_db.collection('user').snapshots().length.toString());
      });

      return order.orderNumber!;
    }
  }

  fetchAllOrders(List orderIds) async {
    final ordersList = await _db
        .collection("order")
        .where("orderNumber", whereIn: orderIds)
        .get();

    if (ordersList.docs.isNotEmpty) {
      return ordersList.docs.map((doc) {
        return order.Order.fromJson(doc.data());
      }).toList();
    }
    return [];
  }
}

// order.Order testObjectConverter(orderObj) {
//   return order.Order(
//     address: orderObj['address'].toString(),
//     booked: orderObj['booked'],
//   );
// }
