import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/order_tracker/order-repository/orderRepository.dart';
import 'package:sample_application/src/screens/Home/order_tracker/orderTracker_progress.dart';

import '../../../../utils/Provider/selected_order_provider.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  GlobalService globalservice = GlobalService();
  bool showAllItems = false;
  int maxVisibleItems = 3;
  OrderRepository orderRepo = OrderRepository();
  Map<String, dynamic> orderItems = {};
  late SelectedOrderState selectedOrder;

  void loadData(Order order) async {
    var totalAmmount = 0;
    var address = "";
    var orderNumber = "";
    List items = [];
    order.tests?.forEach((Test test) {
      items.add({'name': test.testname, 'price': test.price});
      totalAmmount += int.parse(test.price);
    });

    order.totalPrice = totalAmmount;
    String id = await orderRepo.createOrder(order);
    setState(() {
      orderItems = {
        'orderNumber': id,
        'items': items,
        'totalAmount': totalAmmount,
        'address': order?.address,
        'slot': order?.booked?.slot
      };
    });
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in orderItems['items']) {
      total += item['price'] * item['quantity'];
    }
    setState(() {
      orderItems['totalAmount'] = total;
    });
  }

  bool _showBuffering = true;
  @override
  void initState() {
    // TODO: implement initState
    var future = new Future.delayed(const Duration(milliseconds: 1000))
        .then((value) => this.loadData(
              selectedOrder.getOrder,
            ));
    _startBufferingTimer();
    super.initState();
  }

  void _startBufferingTimer() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showBuffering = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);

    return _showBuffering
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
              strokeWidth: 8,
            ), // Show buffering widget
          )
        : Scaffold(
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
                  Text(
                      'Order Number: ${orderItems == null ? "" : orderItems['orderNumber']}',
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
                        Text(orderItems == null
                            ? ""
                            : orderItems['address'].toString()),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Booked Slot',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(orderItems == null
                            ? ""
                            : orderItems['slot'].toString()),
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
                      itemCount: orderItems == null
                          ? 0
                          : orderItems['items'] == null
                              ? 0
                              : orderItems['items'].length,
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
                          selectedOrder.resetOrder();
                          globalservice.navigate(
                              context, OrderTrackingScreen());
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
