import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/order_tracker/confirmation-allert.dart';
import 'package:sample_application/src/core/Provider/selected_order_provider.dart';
import 'package:sample_application/src/core/Provider/selected_test_provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/payment/paymentScreen.dart';
import 'package:sample_application/src/core/helper_widgets/price_container.dart';
import 'package:sample_application/src/core/helper_widgets/slot-booking-card.dart';

import '../../../core/globalServices/execution-stack/execution_stack_operation.dart';
import '../../models/order/order.dart';
import '../../models/package/package.dart';
import '../../models/test/test.dart';
import '../orderTracker_home.dart';

// ignore: must_be_immutable
class OrderSummaryScreen extends StatefulWidget {
  // Map<String, dynamic> orderItems = {};
  // Function() buttonClicked;
  OrderSummaryScreen();
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  double total = 0.0;
  Order order = new Order();
  late SelectedOrderState selectedOrder;
  calculateTotalAmount() {
    total = 0.0;
    for (var item in getItems()) {
      total += int.parse(item['price']); //* item['quantity'];
    }
    // setState(() {
    // widget.orderItems['totalAmount'] = total;
    // });
    return total;
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      order = selectedOrder.getOrder;
      calculateTotalAmount();
      order.totalPrice = total.toInt();
      if (order.orderNumber != null) {
        selectedOrder.createOrder();
      }
    });
  }

  getItems() {
    return [
      ...order.tests!.map((Test test) {
        return {
          'name': test.testName,
          'price': test.price,
          "discount": test.discount,
          "discountedPrice": test.discountedPrice,
          "testObj": test
        };
      }),
      ...order.packages!.map((Package package) {
        return {
          'name': package.packageName,
          'price': package.price,
          "discount": package.discount,
          "discountedPrice": package.discountedPrice,
          'packageObj': package
        };
      })
    ];
  }

  bool expandDetails = false;
  GlobalService globalservice = GlobalService();
  ExecutionStackOperation executionStackOperation = ExecutionStackOperation();
  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context, listen: true);
    selectedOrder = Provider.of<SelectedOrderState>(context);
    order = selectedOrder.getOrder;
    return WillPopScope(
      onWillPop: () async {
        if (order.tests!.length == 0 && order.packages!.length == 0) {
          selectedOrder.removeOrder(order.orderNumber);
        }
        Get.offAll(OrderTrackerHome(
          from: 'cart',
        ));
        Future.delayed(Duration(milliseconds: 200), () {
          selectedOrder.resetOrder();
          selectedTest.removeAllTest();
          selectedTest.removeAllPackage();
        });

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
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

                    Text('Order Number: ${order.orderNumber}',
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
                                  order.address!,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(order.booked!.slot!,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(order.labName!,
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

                        itemCount: getItems().length,
                        itemBuilder: (context, index) {
                          final item = getItems()[index];
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface,
                              ),
                              onPressed: () async {
                                if (item["testObj"] != null) {
                                  selectedTest.removeTest(item["testObj"]);
                                } else {
                                  selectedTest
                                      .removePackage(item["packageObj"]);
                                }
                                order = selectedOrder.getOrder;
                                order.tests = selectedTest.getSelectedTest;
                                order.packages =
                                    selectedTest.getSelectedPackage;
                                await calculateTotalAmount();
                                order.totalPrice = total.toInt();
                                selectedOrder.setOrder = order;

                                selectedOrder.createOrder();

                                //  ...selectedTest.getSelectedTest!
                                //                                       .map((Test test) {
                                //                                     return {
                                //                                       'name': test.testName,
                                //                                       'price': test.price,
                                //                                       "discount": test.discount,
                                //                                       "discountedPrice": test.discountedPrice,
                                //                                       "testObj": test
                                //                                     };
                                //                                   }),
                                //                                   ...selectedTest.getSelectedPackage!
                                //                                       .map((Package package) {
                                //                                     return {
                                //                                       'name': package.packageName,
                                //                                       'price': package.price,
                                //                                       "discount": package.discount,
                                //                                       "discountedPrice":
                                //                                           package.discountedPrice,
                                //                                       'packageObj': package
                                //                                     };
                                //                                   })

                                // getItems(selectedTest).removeAt(2);
                              },
                            ),
                            title: Text(item['name']),
                            subtitle: Price(
                              isTotalPricePresent: false,
                              finalAmount: item['price'],
                              discount: item['discount'],
                              discountedAmount: item["discountedPrice"],
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
                          "₹ ${selectedTest.totalPriceSum.toString()}",
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
                          " % ${selectedTest.discount.toString()}",
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
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                            ),
                            Spacer(),
                            Text(
                              " ₹ ${selectedTest.totalPriceSum - selectedTest.totalDiscountedPriceSum}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
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
                          "₹ ${selectedTest.totalDiscountedPriceSum.toString()}",
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
          (order.tests!.length == 0 && order.packages!.length == 0)
              ? Card()
              : Positioned(
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
                        // content: Price(
                        //   finalAmount: widget.orderItems['totalAmount'].toString(),
                        //   discount: "10",
                        //   totalPrice: true,
                        // ),
                        content: Price(
                            discountedAmount:
                                selectedTest.totalDiscountedPriceSum.toString(),
                            isTotalPricePresent: true,
                            finalAmount: selectedTest.totalPriceSum.toString(),
                            discount: selectedTest.discount.toString()),
                        subContent: "",
                        hyperLink: false,
                        buttonClicked: () {
                          // widget.orderItems['totalAmount'];
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
                )
        ]),
      ),
    );
  }
}
