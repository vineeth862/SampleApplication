import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Home/models/order/order.dart';
import '../../../Home/models/order/payment.dart';
import '../../../Home/order_tracker/orderTracker_progress.dart';
import '../../Provider/selected_order_provider.dart';
import '../../Provider/selected_test_provider.dart';
import '../global_service.dart';

class ServiceScreen extends StatelessWidget {
  Order order;
  ServiceScreen(
      {required this.order,
      required this.selectedOrder,
      required this.selectedTest});
  GlobalService globalservice = GlobalService();
  SelectedOrderState selectedOrder;
  SelectedTestState selectedTest;

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Service Screen'),
      // ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "./assets/images/payment-service-not-available.png",
                  height: 150,
                ),
                const SizedBox(height: 30),
                const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Payment Successful",
                          style: TextStyle(color: Colors.green, fontSize: 25)),
                      Icon(
                        IconData(0xf635, fontFamily: 'MaterialIcons'),
                        size: 30,
                        color: Colors.green,
                      )
                    ]),

                // Spacer(),
                const SizedBox(height: 100),
                const Text(
                  'Thank you for choosing MedcapH.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const Text(
                  'Payments are currently not being Accepted !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary),
                  onPressed: () async {
                    Order order = selectedOrder.getOrder;
                    Payment payment = Payment(
                        amount: order.totalPrice!,
                        brn: "B12345",
                        cardType: "CREDIT_CARD",
                        merchantId: "PGTESTPAYUAT",
                        merchantTransactionId: "1703918305948",
                        paymentMode: "CARD",
                        pgTransactionId: "PG2207221432267522530776",
                        status: true,
                        statusLabel: "Your payment is successful.",
                        transactionDate: "2023-12-30 12:14:19.360465",
                        transactionId: "T2312301213401074655068");
                    payment.transactionDate = DateTime.now().toString();
                    order.payment == null
                        ? order.payment = [payment]
                        : order.payment?.add(payment);

                    order.statusCode = 2;
                    order.statusLabel = "Order Placed";
                    var tempOrder = json.decode(json.encode(order));
                    selectedOrder.setOrder = order;

                    if (order.orderNumber != null) {
                      await selectedOrder.createOrder();
                      // setState(() {
                      selectedOrder.resetOrder();
                      selectedTest.removeAllTest();
                      selectedTest.removeAllPackage();
                      // });
                    }
                    // globalService.showLoader();
                    Get.offAll(
                        OrderTrackingScreen(order: Order.fromJson(tempOrder)));
                  },
                  child: const Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
