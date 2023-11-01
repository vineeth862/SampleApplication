import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';

import '../../../utils/Provider/loading_provider.dart';
import '../../../utils/Provider/selected_order_provider.dart';
import '../models/status/status.dart';
import 'order-summary/orderTrackerDailog.dart';

class OrderTrackingScreen extends StatefulWidget {
  Order? order;
  OrderTrackingScreen({this.order});
  @override
  _OrderTrackingScreenState createState() =>
      _OrderTrackingScreenState(order: order);
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  GlobalService globalservice = GlobalService();
  Order? order;
  Status? status = Status();
  late SelectedOrderState selectedOrder;
  late LoadingProvider loadingProvider;
  int step = 0;
  int currentStep = 0;
  int statusCode = 0;
  _OrderTrackingScreenState({this.order});
  loadData() async {
    await selectedOrder.fetchStatus(order!.statusCode);
    setState(() {
      status = selectedOrder.getStatus;
      step = status!.step!.toInt();
      statusCode = status!.step!.toInt();
      currentStep = step;
      loadingProvider.stopLoading();
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
      selectedOrder = Provider.of<SelectedOrderState>(context, listen: false);
      loadingProvider.startLoading();
      this.loadData();
    });
  }

  String getTechnicianName(technician) {
    return technician != null ? technician['name'] : ' - ';
  }

  String getTechnicianMob(technician) {
    return technician != null ? technician['phone'] : ' - ';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary,
                ]),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Thanks For Choosing",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "MedCapH",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("OrderID: "),
                    subtitle: Text(order!.orderNumber.toString()),
                  ),
                  ListTile(
                    title: Text("Order Status: "),
                    subtitle: Text(order!.statusLabel.toString()),
                  ),
                  ListTile(
                    // leading: Icon(Icons.table_view_outlined),
                    title: Text(
                      "Click here For Order Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 16, 28, 255),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    // tileColor: Colors.blueAccent[700],
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OrderTrackerDialog(
                            order: order!,
                          ); // Custom widget for the dialog content
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Stepper(
                controlsBuilder: (context, controller) {
                  return const SizedBox.shrink();
                },
                currentStep: currentStep,
                onStepTapped: (int index) {
                  setState(() {
                    if (index <= step) {
                      currentStep = index;
                    }
                    // _index = index;
                  });
                },
                steps: <Step>[
                  Step(
                    isActive: step >= 0,
                    title: Text('Order Placed'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Order Created Date :"),
                            subtitle: Text(order!.createdDate.toString()),
                          ),
                          ListTile(
                            title: Text("Booked Slot Time :"),
                            subtitle: Text(order!.booked!.slot.toString()),
                          ),
                          ListTile(
                            title: Text("Booked Address :"),
                            subtitle: Text(order!.address.toString()),
                          )
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: step >= 1,
                    title: Text('Payment Status'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          // ListTile(
                          //   title: Text("Transaction Status:"),
                          //   subtitle: Text(order!.statusLabel.toString()),
                          // ),
                          ListTile(
                            title: Text("Total Amount:"),
                            subtitle: Text(order!.totalPrice.toString()),
                          ),
                          ListTile(
                            title: Text("Transaction Time:"),
                            subtitle: Text("need To update"),
                          ),
                          ListTile(
                            title: Text("Transaction Id:"),
                            subtitle: Text("need to update"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: step >= 2,
                    title: Text('Technician Status'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          // ListTile(
                          //   title: Text("Carrier Status:"),
                          //   subtitle: Text(order!.statusLabel.toString()),
                          // ),
                          ListTile(
                            title: Text("Technician Name:"),
                            subtitle:
                                Text(getTechnicianName(order!.technician)),
                          ),
                          ListTile(
                            title: Text("Technician mob:"),
                            subtitle: Text(getTechnicianMob(order!.technician)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: step >= 3,
                    title: Text('Sample Status'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          // ListTile(
                          //   title: Text("Sample Status:"),
                          //   subtitle: Text(order!.statusLabel.toString()),
                          // ),
                          ListTile(
                            title: Text(" Sample Collected Date:"),
                            subtitle: Text(order!.createdDate.toString()),
                          )
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: step >= 4,
                    title: Text('Report Status'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ListTile(
                              leading: Icon(Icons.download),
                              title: Text("download"))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //OutlinedButton(onPressed: () {}, child: HomePage())
            Divider(
              thickness: 2,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      globalservice.navigate(context, HomePage());
                    },
                    child: Text("Return to Homepage"))),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
