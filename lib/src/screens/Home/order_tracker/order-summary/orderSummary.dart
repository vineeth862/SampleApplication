import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import '../../../../utils/Provider/selected_order_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../payment/paymentScreen.dart';
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

  Future<String> loadData() async {
    Order order = await selectedOrder.getOrder;
    var totalAmmount = 0;
    order.totalPrice = totalAmmount;

    orderItems = {
      'orderNumber': order.orderNumber,
      'items': [
        ...order.tests!.map((Test test) {
          totalAmmount += int.parse(test.price);
          return {'name': test.testname, 'price': test.price};
        })
      ],
      'totalAmount': totalAmmount,
      'address': order.address,
      'slot': order.booked?.slot
    };
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
                Order order = selectedOrder.getOrder;
                order.statusCode = 1;
                order.statusLabel = "Payment Pending";
                selectedOrder.setOrder = order;
                await selectedOrder.createOrder();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => PaymentScreeen()));
                // globalservice.navigate(context, PaymentScreeen());
              },
            );
          }
        });
  }
}
