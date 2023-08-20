import "package:flutter/material.dart";
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';

import '../../../utils/Provider/loading_provider.dart';
import '../../../utils/Provider/selected_order_provider.dart';
import '../models/status/status.dart';

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
                  Color.fromARGB(255, 20, 104, 23),
                  Color.fromARGB(255, 17, 137, 21)
                ]),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Thanks For Choosing",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Health Fine",
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
              child: Text(
                "OrderID: " + widget.order!.orderNumber.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 5),
            Stepper(
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
                        ListTile(
                          title: Text("carrier Name:"),
                          subtitle: Text(order!.createdDate.toString()),
                        ),
                        ListTile(
                          title: Text("contact Carrier:"),
                          subtitle: Text(order!.createdDate.toString()),
                        )
                      ],
                    ),
                  ),
                ),
                Step(
                  isActive: step >= 2,
                  title: Text('Carrier Status'),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("sample name:"),
                          subtitle: Text(order!.createdDate.toString()),
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
                        ListTile(
                          title: Text("lab Name:"),
                          subtitle: Text(order!.createdDate.toString()),
                        ),
                        ListTile(
                          title: Text("recieved Time:"),
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
