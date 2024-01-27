import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/order_tracker/order-summary/orderSumaryScreen.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';

import '../../../core/Provider/selected_order_provider.dart';
import '../../../core/Provider/selected_test_provider.dart';

class OrderTrackerDialog extends StatefulWidget {
  Order order;

  OrderTrackerDialog({super.key, required this.order});

  @override
  State<OrderTrackerDialog> createState() => _OrderTrackerDialogState();
}

class _OrderTrackerDialogState extends State<OrderTrackerDialog> {
  GlobalService globalservice = GlobalService();
  SelectedTestState? selectedTest;
  SelectedOrderState? selectedOrder;

  String generateString(value) {
    return value == null ? '' : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    selectedTest = Provider.of<SelectedTestState>(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Order Id : ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            widget.order.orderNumber!,
            softWrap: true,
          ),
        ],
      ),
      // titlePadding: EdgeInsets.only(top: 15, left: 20, bottom: 25),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // shape: Theme.of(context).cardTheme.shape,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 246, 197, 117)
                          .withOpacity(0.5)),

                  // color: Color.fromARGB(255, 255, 181, 71),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 255, 214),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        )),
                    // color: Color.fromARGB(255, 255, 210, 138),
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "User Information",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        // Divider(
                        //   color: Colors.grey, // You can customize the color
                        //   thickness: 1.0, // You can customize the thickness
                        // ),
                        const SizedBox(height: 20),
                        Row(children: [
                          Text('Patient Name : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                            generateString(widget.order.patient?.userName),
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          )
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Text('Mobile : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                              generateString(widget.order.patient?.mobile)
                                  .substring(3, 13),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // shape: Theme.of(context).cardTheme.shape,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 246, 197, 117)
                          .withOpacity(0.5)),

                  // color: Color.fromARGB(255, 255, 181, 71),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 255, 214),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        )),
                    // color: Color.fromARGB(255, 255, 210, 138),
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Collection Information",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Text('Sample PickUp On : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                              generateString(widget.order.booked?.bookedDate
                                  ?.substring(0, 10)),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Text('Collection Slot : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(generateString(widget.order.booked?.bookedSlot),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Text('Address : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Expanded(
                            child: Text(widget.order.address!.fullAddress!,
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: Theme.of(context).textTheme.bodyMedium),
                          )
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Text('Lab Name : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Expanded(
                            child: Text(
                              widget.order.labName!,
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                            ),
                          )
                        ]),
                        const SizedBox(height: 8.0),
                        Row(children: [
                          Text('Booked Items : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ]),
                        Row(children: [
                          Expanded(
                            child: Text(
                              widget.order.tests!
                                      .map((e) => e.displayName)
                                      .join(",  ") +
                                  (widget.order.packages!.isNotEmpty
                                      ? ',  '
                                      : '') +
                                  widget.order.packages!
                                      .map((e) => e.displayName)
                                      .join(",  "),
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          )
                        ]),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text('Booked Tests : ',
                        //       style: Theme.of(context).textTheme.titleSmall),
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Container(
                        //     width: MediaQuery.of(context).size.width * 0.90,
                        //     height: 30 * order.tests!.length.toDouble(),
                        //     child: ListView.builder(
                        //       itemCount: order.tests!.length,
                        //       itemBuilder: (context, index) => Column(
                        //         children: [
                        //           Text(order.tests![index].displayName,
                        //               softWrap: true,
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .titleMedium),
                        //           SizedBox(height: 10),
                        //         ],
                        //       ),
                        //     ))
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // shape: Theme.of(context).cardTheme.shape,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 246, 197, 117)
                          .withOpacity(0.5)),

                  // color: Color.fromARGB(255, 255, 181, 71),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 255, 214),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        )),
                    // color: Color.fromARGB(255, 255, 210, 138),
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Payment Information",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Text('Item Total : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(widget.order.totalPrice.toString(),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Text('Sample Collection Charge : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const Text(
                            'FREE',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 119, 0)),
                          )
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Text('Payable Amount : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(widget.order.totalPrice.toString(),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        const SizedBox(height: 10),
                        // Row(children: [
                        //   Text('Payment Mode : ',
                        //       style: Theme.of(context).textTheme.titleSmall),
                        //   Text('Need Confirmation',
                        //       style: Theme.of(context).textTheme.titleMedium)
                        // ]),
                        const SizedBox(height: 25),
                        widget.order.statusCode == 1
                            ? ElevatedButton(
                                onPressed: () {
                                  selectedOrder?.setOrder = widget.order;
                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    widget.order.packages?.forEach((package) {
                                      selectedTest?.addPackage(package);
                                    });
                                  });
                                  widget.order.tests?.forEach((test) {
                                    selectedTest?.addTest(test);
                                  });

                                  Future.delayed(
                                      const Duration(milliseconds: 400), () {
                                    globalservice.navigate(
                                        context, OrderSummaryScreen());
                                  });
                                },
                                child: const Text('Proceed'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.tertiary),
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Text("User Actions")
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
