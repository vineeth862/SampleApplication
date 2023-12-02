import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/models/event-logs/event-logs.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/models/package/package.dart';
import 'package:sample_application/src/Home/models/test/test.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../core/Provider/selected_order_provider.dart';
import '../../../core/Provider/selected_test_provider.dart';
import '../../../core/globalServices/payment/paymentScreen.dart';
import 'orderSumaryScreen.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  GlobalService globalservice = GlobalService();
  Map<String, dynamic> orderItems = {};
  late SelectedTestState selectedTest;
  late SelectedOrderState selectedOrder;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) => loadData());
  }

  addLog() {
    Order order = selectedOrder.getOrder;
    EventLog event = EventLog(
        dateTime: "skndkbd",
        event: "OrderCreation",
        eventType: "Creation",
        id: "",
        metaData: order.toJson(),
        module: "OrderTracker",
        userDetails: order.user!);
    // eventLogService.addLog(event);
  }

  Future<String> loadData() async {
    Order order = await selectedOrder.getOrder;
    int totalAmmount = 0;

    orderItems = {
      'orderNumber': order.orderNumber,
      'items': [
        ...order.tests!.map((Test test) {
          totalAmmount += int.parse(test.price);
          return {
            'name': test.testName,
            'price': test.price,
            "discount": test.discount,
            "discountedPrice": test.discountedPrice,
            "testObj": test
          };
        }),
        ...order.packages!.map((Package package) {
          totalAmmount += int.parse(package.price.toString());
          return {'name': package.packageName, 'price': package.price};
        })
      ],
      'totalAmount': totalAmmount,
      'address': order.address,
      'slot': order.booked?.slot,
      'labName': order.labName
    };
    order.totalPrice = totalAmmount;
    order.createdDate = new DateTime.now().toString();
    selectedOrder.setOrder = order;

    return "sccess";
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    selectedTest = Provider.of<SelectedTestState>(context);

    return FutureBuilder<String>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(150.0),
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Theme.of(context).colorScheme.primary],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return OrderSummaryScreen(
              orderItems: orderItems,
              buttonClicked: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => PaymentScreeen()));
                // globalservice.navigate(context, PaymentScreeen());
              },
            );
          }
        });
  }
}
