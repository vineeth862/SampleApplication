import 'package:flutter/material.dart';

class OrderSummaryScreen extends StatefulWidget {
  Map<String, dynamic> orderItems = {};
  Function() buttonClicked;
  OrderSummaryScreen({required this.orderItems, required this.buttonClicked});
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  void calculateTotalAmount() {
    double total = 0.0;

    for (var item in widget.orderItems['items']) {
      total += int.parse(item['price']); //* item['quantity'];
    }
    setState(() {
      widget.orderItems['totalAmount'] = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Center(
          child: Container(
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
            Text(
                'Order Number: ${widget.orderItems == null ? "" : widget.orderItems['orderNumber']}',
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
                  Text(widget.orderItems == null
                      ? ""
                      : widget.orderItems['address'].toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Booked Slot',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(widget.orderItems == null
                      ? ""
                      : widget.orderItems['slot'].toString()),
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
                // itemCount: maxVisibleItems < widget.orderItems['items'].length
                //     ? maxVisibleItems + 1
                //     : widget.orderItems['items'].length,
                itemCount: widget.orderItems == null
                    ? 0
                    : widget.orderItems['items'] == null
                        ? 0
                        : widget.orderItems['items'].length,
                itemBuilder: (context, index) {
                  // if (index == maxVisibleItems) {
                  //   return TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         maxVisibleItems = widget.orderItems['items'].length;
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
                  final item = widget.orderItems['items'][index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.orderItems['items'].removeAt(index);
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
                  'Total: \Rs. ${widget.orderItems['totalAmount']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.buttonClicked,
                  child: Text('Proceed to Payment'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
