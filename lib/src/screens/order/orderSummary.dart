import 'package:flutter/material.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/order_tracker/orderTracker_progress.dart';
import 'package:sample_application/src/screens/order/paymentGateway.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  GlobalService globalservice = GlobalService();
  bool showAllItems = false;
  int maxVisibleItems = 3;
  final Map<String, dynamic> orderItems = {
    'orderNumber': '12345',
    'items': [
      {'name': 'Item 1', 'price': 20.0, 'quantity': 2},
      {'name': 'Item 2', 'price': 15.0, 'quantity': 3},
      {'name': 'Item 1', 'price': 20.0, 'quantity': 2},
      // {'name': 'Item 2', 'price': 15.0, 'quantity': 3},
      // {'name': 'Item 1', 'price': 20.0, 'quantity': 2},
      // {'name': 'Item 2', 'price': 15.0, 'quantity': 3},
      // {'name': 'Item 1', 'price': 20.0, 'quantity': 2},
      // {'name': 'Item 2', 'price': 150.0, 'quantity': 3},
    ],
    'totalAmount': 85.0,
    'address': '1234 Main St, City, Country',
    'slot': '27/10/2023 4pm-5pm'
  };
  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in orderItems['items']) {
      total += item['price'] * item['quantity'];
    }
    setState(() {
      orderItems['totalAmount'] = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Order Details',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 16),
            Text('Order Number: ${orderItems['orderNumber']}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 150, 224, 153),
                    Color.fromARGB(255, 22, 190, 28),
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample collection address',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(orderItems['address']),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Booked Slot',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(orderItems['slot']),
                ],
              ),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                // itemCount: maxVisibleItems < orderItems['items'].length
                //     ? maxVisibleItems + 1
                //     : orderItems['items'].length,
                itemCount: orderItems['items'].length,
                itemBuilder: (context, index) {
                  // if (index == maxVisibleItems) {
                  //   return TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         maxVisibleItems = orderItems['items'].length;
                  //       });
                  //     },
                  //     child: Text(
                  //       'Load More',
                  //       style: TextStyle(
                  //         color: Colors.blue,
                  //       ),
                  //     ),
                  //   );
                  // }
                  final item = orderItems['items'][index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          orderItems['items'].removeAt(index);
                          calculateTotalAmount();
                        });
                      },
                    ),
                    title: Text(item['name']),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Text('\$${item['price']}'),
                  );
                },
              ),
            ),

            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \Rs. ${orderItems['totalAmount']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    globalservice.navigate(context, OrderTrackingScreen());
                  },
                  child: Text('Proceed to Payment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
