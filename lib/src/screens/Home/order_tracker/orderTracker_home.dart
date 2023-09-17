import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/Home/order_tracker/order-repository.dart';
import 'package:sample_application/src/screens/Home/order_tracker/payment/paymentScreen.dart';
import 'package:sample_application/src/utils/Provider/loading_provider.dart';

import '../../../authentication/user_repository.dart';
import '../../../global_service/global_service.dart';
import '../../../utils/Provider/selected_order_provider.dart';
import '../models/test/test.dart';
import 'orderTracker_progress.dart';

class OrderTrackerHome extends StatefulWidget {
  OrderTrackerHome({super.key, required this.from});
  String from;
  @override
  State<OrderTrackerHome> createState() => _OrderTrackerHomeState();
}

class _OrderTrackerHomeState extends State<OrderTrackerHome> {
  // List items = List.generate(4, (index) => ' ');
  bool isLoading = true;
  GlobalService globalservice = GlobalService();
  late SelectedOrderState selectedOrder;
  late LoadingProvider loadingProvider;
  List<dynamic> orders = [];

  loadData() async {
    final orderIds = await UserRepository().getOrderIds();
    final orderRepo = OrderRepository();
    await orderRepo.fetchAllOrders(orderIds, widget.from);

    setState(() {
      orders = orderRepo.orderList;
      loadingProvider.stopLoading();
    });
  }

  void navigate(Order order, context) {
    // if (order.statusCode == 1) {
    //   this.globalservice.navigate(context, PaymentScreeen());
    // } else {
    this.globalservice.navigate(
        context,
        OrderTrackingScreen(
          order: order,
        ));
    // }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.startLoading();
      this.loadData();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    //CHNAGE THIS LOGIC IN FUTURE
    final loadingProvider = Provider.of<LoadingProvider>(context);
    return loadingProvider.isLoading
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(160.0),
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Theme.of(context).colorScheme.primary],
                strokeWidth: 10,
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "|",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.from == "cart"
                                ? "Your Cart"
                                : "Your Bookings",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.84, //DONT CHANGE THIS HEIGHT VALUE NEED TO TEST
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        itemCount: orders
                            .length, //GET THE COUNT OF BOOKING DONE BY USER AND UPDATE HERE
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.2),
                                    width: 2.0,
                                  ),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.grey.shade50,
                                        Colors.grey.shade100,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.4),
                                          Theme.of(context).colorScheme.primary
                                        ]),
                                        // borderRadius: BorderRadius.only(
                                        //   bottomLeft: Radius.circular(20.0),
                                        //   bottomRight: Radius.circular(20.0),
                                        // ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                orders[index]
                                                    .tests![0]
                                                    .labName, //CHANGE THE NAME TO PARTICULAR LAB NAME
                                                // textAlign: TextAlign.start,
                                                maxLines: 5,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            // Spacer(),
                                            Expanded(
                                              child: TextButton.icon(
                                                // icon: Icon(
                                                //   Icons.wifi_protected_setup_sharp,
                                                //   size: 15,
                                                // ),
                                                icon: const Icon(
                                                  Icons.done_all_rounded,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {},
                                                label: Text(
                                                  orders[index].statusLabel!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ), //UYPDATE COLOR OF THE BUTTON AND STATUS BASED ON THE ORDER STATUS
                                                // style: OutlinedButton.styleFrom(
                                                //   //minimumSize: Size(10, 30),
                                                //   shape: RoundedRectangleBorder(
                                                //     borderRadius:
                                                //         BorderRadius.circular(10.0),
                                                //   ),
                                                //   backgroundColor:
                                                //       Color.fromARGB(255, 169, 208, 172),
                                                // ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Divider(
                                    //   height: 5,
                                    //   thickness: 1,
                                    // ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Booked Test",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ...orders[index]
                                        .tests!
                                        .map((Test item) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(item.testName),
                                              ),
                                            )),
                                    const Divider(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            orders[index].booked!.slot!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        const SizedBox(width: 70),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                navigate(
                                                    orders[index], context);
                                              },
                                              child: const Text("Track Order"),
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(10, 30),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
