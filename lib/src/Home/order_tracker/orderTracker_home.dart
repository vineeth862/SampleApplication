import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/models/package/package.dart';
import 'package:sample_application/src/Home/order_tracker/order-repository.dart';
import 'package:sample_application/src/Home/order_tracker/orderTracker_progress.dart';

import '../../core/Provider/selected_order_provider.dart';
import '../../core/globalServices/authentication/user_repository.dart';
import '../../core/globalServices/global_service.dart';
import '../../core/helper_widgets/no_orders_found.dart';
import '../../core/helper_widgets/no_result_found.dart';
import '../models/test/test.dart';
import 'order-summary/orderTrackerDailog.dart';
import 'package:sample_application/src/Home/order_tracker/orderTrackerCard.dart';

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
  List<Order> orders = [];

  loadData() async {
    final orderIds = await UserRepository().getOrderIds();
    final orderRepo = OrderRepository();
    await orderRepo.fetchAllOrders(orderIds, widget.from);
    globalservice.hideLoader();
    setState(() {
      orders = orderRepo.orderList;
      // globalservice.hideLoader();
    });
  }

  void navigate(Order order, context) {
    if (order.statusCode == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderTrackerDialog(
            order: order,
          ); // Custom widget for the dialog content
        },
      );
    } else {
      this.globalservice.navigate(
          context,
          OrderTrackingScreen(
            order: order,
          ));
      // orderTraExp());
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      globalservice.showLoader();
      this.loadData();
    });

    // TODO: implement initState
    super.initState();
  }

  getBookedItems(i) {
    final list = [];

    orders[i].tests?.forEach((Test item) => list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Test -" + item.testName),
          ),
        )));

    orders[i].packages?.forEach((Package item) => list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Package -" + item.packageName),
          ),
        )));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    //CHNAGE THIS LOGIC IN FUTURE
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(HomePage());
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "|",
                            style: TextStyle(
                                color: Color.fromARGB(220, 219, 24, 24),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.from == "cart"
                                ? "Your Cart"
                                : "Your Bookings",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  orders.length == 0
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.83, //DONT CHANGE THIS HEIGHT VALUE NEED TO TEST
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Center(
                            child: NoOrdersFoundCard(
                              title: widget.from == "cart"
                                  ? 'Your Cart is Empty'
                                  : 'No Booked Orders Found!',
                            ),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.8, //DONT CHANGE THIS HEIGHT VALUE NEED TO TEST
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).size.width < 600
                                      ? 1
                                      : 2,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width < 600
                                      ? 1.2
                                      : 1.6, // number of items in each row
                              mainAxisSpacing: 4.0, // spacing between rows
                              crossAxisSpacing: 16.0, // spacing between columns
                            ),
                            itemCount: orders
                                .length, //GET THE COUNT OF BOOKING DONE BY USER AND UPDATE HERE
                            itemBuilder: (context, index) {
                              return orderTrackerCard(
                                order: orders[index],
                                removeOrder: (order) {
                                  globalservice.showLoader();
                                  selectedOrder
                                      .removeOrderFromCart(order.orderNumber);
                                  this.loadData();
                                },
                              );
                              // return Column(
                              //   children: [
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width * 0.9,
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color: Theme.of(context)
                              //               .colorScheme
                              //               .primary
                              //               .withOpacity(0.2),
                              //           width: 2.0,
                              //         ),
                              //         gradient: LinearGradient(
                              //             colors: [
                              //               Colors.grey.shade50,
                              //               const Color.fromARGB(
                              //                   255, 255, 255, 255),
                              //             ],
                              //             begin: Alignment.topLeft,
                              //             end: Alignment.bottomRight),
                              //         borderRadius: const BorderRadius.only(
                              //           bottomLeft: Radius.circular(20.0),
                              //           bottomRight: Radius.circular(20.0),
                              //         ),
                              //       ),
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Container(
                              //             decoration: BoxDecoration(
                              //               gradient: LinearGradient(colors: [
                              //                 Theme.of(context)
                              //                     .colorScheme
                              //                     .primary
                              //                     .withOpacity(0.4),
                              //                 Theme.of(context)
                              //                     .colorScheme
                              //                     .primary
                              //               ]),
                              //               // borderRadius: BorderRadius.only(
                              //               //   bottomLeft: Radius.circular(20.0),
                              //               //   bottomRight: Radius.circular(20.0),
                              //               // ),
                              //             ),
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Row(
                              //                 children: [
                              //                   Expanded(
                              //                     child: Text(
                              //                       orders[index]
                              //                           .labName!, //CHANGE THE NAME TO PARTICULAR LAB NAME
                              //                       // textAlign: TextAlign.start,
                              //                       maxLines: 5,
                              //                       overflow:
                              //                           TextOverflow.visible,
                              //                       softWrap: true,
                              //                       style: Theme.of(context)
                              //                           .textTheme
                              //                           .headlineSmall,
                              //                     ),
                              //                   ),
                              //                   // Spacer(),
                              //                   Expanded(
                              //                     child: TextButton.icon(
                              //                       // icon: Icon(
                              //                       //   Icons.wifi_protected_setup_sharp,
                              //                       //   size: 15,
                              //                       // ),
                              //                       icon: const Icon(
                              //                         Icons.done_all_rounded,
                              //                         size: 15,
                              //                         color: Colors.black,
                              //                       ),
                              //                       onPressed: () {},
                              //                       label: Text(
                              //                         orders[index]
                              //                             .statusLabel!,
                              //                         style: Theme.of(context)
                              //                             .textTheme
                              //                             .titleMedium,
                              //                       ), //UYPDATE COLOR OF THE BUTTON AND STATUS BASED ON THE ORDER STATUS
                              //                       // style: OutlinedButton.styleFrom(
                              //                       //   //minimumSize: Size(10, 30),
                              //                       //   shape: RoundedRectangleBorder(
                              //                       //     borderRadius:
                              //                       //         BorderRadius.circular(10.0),
                              //                       //   ),
                              //                       //   backgroundColor:
                              //                       //       Color.fromARGB(255, 169, 208, 172),
                              //                       // ),
                              //                     ),
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //           ),

                              //           // Divider(
                              //           //   height: 5,
                              //           //   thickness: 1,
                              //           // ),
                              //           const SizedBox(
                              //             height: 5,
                              //           ),
                              //           Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 10),
                              //             child: Text(
                              //               "Booked Items",
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .headlineSmall,
                              //             ),
                              //           ),
                              //           ...getBookedItems(index),
                              //           const Divider(
                              //             height: 5,
                              //           ),
                              //           Row(
                              //             children: [
                              //               Expanded(
                              //                 child: Padding(
                              //                   padding:
                              //                       const EdgeInsets.symmetric(
                              //                           horizontal: 8.0),
                              //                   child: Text(
                              //                     "Booked Slot " +
                              //                         orders[index]
                              //                             .booked!
                              //                             .slot!,
                              //                     style: Theme.of(context)
                              //                         .textTheme
                              //                         .bodySmall,
                              //                   ),
                              //                 ),
                              //               ),
                              //               const Spacer(),
                              //               Padding(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         horizontal: 8),
                              //                 child: ElevatedButton(
                              //                   onPressed: () {
                              //                     navigate(
                              //                         orders[index], context);
                              //                   },
                              //                   child:
                              //                       const Text("Track Order"),
                              //                   style: ElevatedButton.styleFrom(
                              //                       minimumSize:
                              //                           const Size(10, 30),
                              //                       shape:
                              //                           RoundedRectangleBorder(
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 10.0),
                              //                       ),
                              //                       backgroundColor:
                              //                           Theme.of(context)
                              //                               .colorScheme
                              //                               .primary),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       height: 12,
                              //     )
                              //   ],
                              // );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
