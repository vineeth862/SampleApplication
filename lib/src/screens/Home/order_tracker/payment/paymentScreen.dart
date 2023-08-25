import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/Provider/selected_order_provider.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../../models/order/order.dart';

class PaymentScreeen extends StatefulWidget {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    selectedTest = Provider.of<SelectedTestState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Make Payment here',
            ),
            Text(
              '$_payment',
              style: Theme.of(context).textTheme.headline4,
            ),
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
