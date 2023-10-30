import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/order_tracker/orderTracker_progress.dart';

import '../../../../utils/Provider/selected_order_provider.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../../models/order/order.dart';

class PaymentScreeen extends StatefulWidget {
  //final String? totalAmount;

  //const PaymentScreeen({required this.totalAmount});
  @override
  _MyPaymentScreeen createState() => _MyPaymentScreeen();
}

class _MyPaymentScreeen extends State<PaymentScreeen> {
  String _payment = "do Payment";
  late SelectedOrderState selectedOrder;
  late SelectedTestState selectedTest;
  void _doPayment() async {
    _payment = "Payment Successfull";
    Order order = selectedOrder.getOrder;
    order.statusCode = 2;
    order.statusLabel = "Payment Successfull";
    selectedOrder.setOrder = order;
    if (order.orderNumber != null) {
      await selectedOrder.createOrder();
      setState(() {
        selectedOrder.resetOrder();
        selectedTest.removeAllTest();
        selectedTest.removeAllPackage();
      });
    }
    globalservice.navigate(context, OrderTrackingScreen(order: order));
  }

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    selectedTest = Provider.of<SelectedTestState>(context);
    Order order = selectedOrder.getOrder;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pay Using",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () async {
                  // Handle edit profile button press
                  final res =
                      await EasyUpiPaymentPlatform.instance.startPayment(
                    EasyUpiPaymentModel(
                      payeeVpa: 'Q720679555@ybl',
                      payeeName: 'MedcapH',
                      amount: double.parse(order.totalPrice.toString()),
                      description: 'Testing payment',
                    ),
                  );

                  if (res?.responseCode == "00") {
                    _doPayment();
                  } else {
                    AlertDialog(
                      //icon: Icon(Icons.time_to_leave),
                      alignment: const AlignmentDirectional(1, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text("Oh,no!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                      content: Text(
                        "Transaction failed",
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      actions: [
                        // Define buttons for the AlertDialog
                        ElevatedButton(
                          style: ButtonStyle(
                              // minimumSize: MaterialStateProperty.all(
                              //     const Size(80, 25)), // Set the desired size
                              ),
                          child: const Text("Try Again"),
                          onPressed: () {},
                        ),
                      ],
                      actionsAlignment: MainAxisAlignment.end,
                    );
                  }
                },
                child: Card(
                  color: Theme.of(context).colorScheme.tertiary,
                  child: ListTile(
                    leading: Icon(Icons.payments),
                    title: Text(
                      "UPI",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _doPayment,
        tooltip: 'pay',
        child: Icon(Icons.payment_outlined),
      ),
    );
  }
}
