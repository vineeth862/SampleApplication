import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/core/globalServices/payment/paymentScreen.dart';

import '../../../core/Provider/selected_order_provider.dart';

class OrderTrackerDialog extends StatefulWidget {
  Order order;

  OrderTrackerDialog({super.key, required this.order});

  @override
  State<OrderTrackerDialog> createState() => _OrderTrackerDialogState();
}

class _OrderTrackerDialogState extends State<OrderTrackerDialog> {
  GlobalService globalservice = GlobalService();

  SelectedOrderState? selectedOrder;

  String generateString(value) {
    return value == null ? '' : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // shape: Theme.of(context).cardTheme.shape,
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          Color.fromARGB(255, 246, 197, 117).withOpacity(0.5)),

                  // color: Color.fromARGB(255, 255, 181, 71),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 131),
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
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // Divider(
                        //   color: Colors.grey, // You can customize the color
                        //   thickness: 1.0, // You can customize the thickness
                        // ),
                        SizedBox(height: 20),
                        Row(children: [
                          Text('Patient Name : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                            generateString(widget.order.user?.userName),
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          )
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          Text('Mobile : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                              generateString(widget.order.user?.mobile)
                                  .substring(3, 13),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // shape: Theme.of(context).cardTheme.shape,
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          Color.fromARGB(255, 246, 197, 117).withOpacity(0.5)),

                  // color: Color.fromARGB(255, 255, 181, 71),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 131),
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
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 15),
                        Row(children: [
                          Text('Sample PickUp On : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                              generateString(widget.order.booked?.bookedDate
                                  ?.substring(0, 10)),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          Text('Collection Slot : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(generateString(widget.order.booked?.bookedSlot),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          Text('Address : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Expanded(
                            child: Text(widget.order.address!,
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: Theme.of(context).textTheme.bodyMedium),
                          )
                        ]),
                        SizedBox(height: 10),
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
                        SizedBox(height: 8.0),
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

            SizedBox(height: 16.0),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // shape: Theme.of(context).cardTheme.shape,
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          Color.fromARGB(255, 246, 197, 117).withOpacity(0.5)),

                  // color: Color.fromARGB(255, 255, 181, 71),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 131),
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 15),
                        Row(children: [
                          Text('Item Total : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(widget.order.totalPrice.toString(),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          Text('Sample Collection Charge : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                            'FREE',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 119, 0)),
                          )
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          Text('Payable Amount : ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(widget.order.totalPrice.toString(),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                        SizedBox(height: 10),
                        // Row(children: [
                        //   Text('Payment Mode : ',
                        //       style: Theme.of(context).textTheme.titleSmall),
                        //   Text('Need Confirmation',
                        //       style: Theme.of(context).textTheme.titleMedium)
                        // ]),
                        SizedBox(height: 25),
                        widget.order.statusCode == 1
                            ? ElevatedButton(
                                onPressed: () {
                                  selectedOrder?.setOrder = widget.order;
                                  globalservice.navigate(
                                      context, PaymentScreeen());
                                },
                                child: Text('Proceed Payment'),
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
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
