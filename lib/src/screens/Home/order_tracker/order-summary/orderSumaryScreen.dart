import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/Home/order_tracker/confirmation-allert.dart';
import 'package:sample_application/src/screens/Home/order_tracker/payment/paymentScreen.dart';
import 'package:sample_application/src/utils/Provider/selected_order_provider.dart';
import 'package:sample_application/src/utils/helper_widgets/price_container.dart';
import 'package:sample_application/src/utils/helper_widgets/slot-booking-card.dart';

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

  bool expandDetails = false;
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final selectedOrder = Provider.of<SelectedOrderState>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Order Summary',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
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

                  Text(
                      'Order Number: ${widget.orderItems == null ? "" : widget.orderItems['orderNumber']}',
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.home_outlined,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Sample collection address :',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Icon(
                            //   Icons.arrow_forward,
                            //   size: 12,
                            // ),
                            Expanded(
                              child: Text(
                                widget.orderItems == null
                                    ? ""
                                    : widget.orderItems['address'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('Booked Slot :',
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                                widget.orderItems == null
                                    ? ""
                                    : widget.orderItems['slot'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.local_hospital,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('Lab :',
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                                widget.orderItems == null
                                    ? ""
                                    : widget.orderItems['labName'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 2),
                  // const SizedBox(height: 5),

                  Text('Test/Packages',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true, // Set this to true
                      physics: NeverScrollableScrollPhysics(),

                      itemCount: widget.orderItems == null
                          ? 0
                          : widget.orderItems['items'] == null
                              ? 0
                              : widget.orderItems['items'].length,
                      itemBuilder: (context, index) {
                        final item = widget.orderItems['items'][index];
                        return ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.orderItems['items'].removeAt(index);
                                calculateTotalAmount();
                              });
                            },
                          ),
                          title: Text(item['name']),
                          subtitle: Price(
                            totalPrice: false,
                            finalAmount: item['price'],
                            discount: "10",
                          ),
                          leading: Icon(
                            Icons.check_box_sharp,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: Allert(),
                          ); // Custom widget for the dialog content
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add More Test/Packages",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text("Payment details",
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "MRP",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacer(),
                      Text(
                        "₹ ${widget.orderItems['totalAmount']}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "MedCapH Discount",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacer(),
                      Text(
                        " - ₹ ${widget.orderItems['totalAmount']}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Sample Collection Charges",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacer(),
                      Text(
                        "₹100",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black26),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Free",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Theme.of(context).colorScheme.tertiary),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Total Savings",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                          ),
                          Spacer(),
                          Text(
                            " ₹ ${widget.orderItems['totalAmount']}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Text(
                        "Amount Payable",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacer(),
                      Text(
                        "₹ ${widget.orderItems['totalAmount']}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 180)

                  // const Divider(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Total: \Rs. ${widget.orderItems['totalAmount']}',
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: widget.buttonClicked,
                  //       child: const Text('Proceed to Payment'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              height: 150,
              child: SlotBookingCard(
                selectedCount: 0,
                title: "Total amount payable",
                contentColor: false,
                height: 150,
                content: Price(
                  finalAmount: widget.orderItems['totalAmount'].toString(),
                  discount: "10",
                  totalPrice: true,
                ),
                subContent: "",
                hyperLink: false,
                buttonClicked: () {
                  widget.orderItems['totalAmount'];
                  // Widget widget = order.statusCode == 1
                  //     ? PaymentScreeen()
                  //     : StepOneToBookTest();

                  globalservice.navigate(context, PaymentScreeen());
                },
                expandDetail: () {
                  setState(() {
                    expandDetails = false;
                  });
                },
              )),
        ),
      ]),
    );
  }
}
