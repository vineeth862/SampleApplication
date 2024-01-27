import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/explore/Search/search_field.dart';
import 'package:sample_application/src/Home/models/test/test.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';

import '../../../../core/Provider/selected_order_provider.dart';
import '../../../../core/Provider/selected_test_provider.dart';
import '../../../../core/helper_widgets/price_container.dart';
import '../../../../core/helper_widgets/slot-booking-card.dart';
import '../../../models/order/order.dart';
import '../../../order_tracker/order-summary/orderSumaryScreen.dart';
import '../../../order_tracker/step1/step1.dart';

class CardDetailPage extends StatefulWidget {
  CardDetailPage({super.key, required this.test});
  Test test;
  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  GlobalService globalservice = GlobalService();
  bool expandDetails = false;

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    final selectedOrder = Provider.of<SelectedOrderState>(context);
    num slotBookingCardHeight = 120;
    List<dynamic> list = searchState.getTestCardList;
    bool isTestSelected(Test test) {
      return (selectedTest.getSelectedTest
          .where((element) =>
              element.medCapTestCode == test.medCapTestCode &&
              element.labCode == test.labCode)
          .isNotEmpty);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Test Details",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(219, 229, 233, 1),
              padding: const EdgeInsets.all(8),
              child: ListView(children: [
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.test.testName,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),

                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Text("test : ",
                        //         style: Theme.of(context).textTheme.labelLarge),
                        //     Expanded(
                        //       child: Text(widget.test.testName,
                        //           maxLines: 2,
                        //           softWrap: true,
                        //           style:
                        //               Theme.of(context).textTheme.titleSmall),
                        //     )
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Lab : ",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text(widget.test.labName,
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Sample Required : ",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text(widget.test.sampletypeName,
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Method : ",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text("Not Specified",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Price : ",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Price(
                              discount: widget.test.discount,
                              isTotalPricePresent: false,
                              discountedAmount: widget.test.discountedPrice,
                              finalAmount: widget.test.price,
                            )
                            // Text("₹" + widget.test.price,
                            //     style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Report : ",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text(widget.test.tat + " Hours",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    String userKey =
                                        globalservice.getCurrentUserKey();
                                    if (userKey != "null") {
                                      Order order = selectedOrder.getOrder;
                                      if (isTestSelected(widget.test)) {
                                        selectedTest.removeTest(widget.test);
                                        order.tests =
                                            selectedTest.getSelectedTest;
                                      } else {
                                        selectedTest.addTest(widget.test);
                                        order.tests =
                                            selectedTest.getSelectedTest;
                                      }
                                      if (selectedTest!
                                                  .getSelectedPackage.length ==
                                              0 &&
                                          selectedTest!
                                                  .getSelectedTest.length ==
                                              0) {
                                      } else if (order.statusCode == 1 &&
                                              globalservice
                                                      .getLength(order.tests) >
                                                  0 ||
                                          globalservice
                                                  .getLength(order.packages) >
                                              0) {
                                        Get.off(() => OrderSummaryScreen());
                                      } else if (globalservice
                                                  .getLength(order.tests) >
                                              0 ||
                                          globalservice
                                                  .getLength(order.packages) >
                                              0) {
                                        globalservice.navigate(
                                            context, StepOneToBookTest());
                                      } else {
                                        Get.off(() => const SearchBarPage());
                                        selectedOrder.resetOrder();
                                        selectedTest.removeAllTest();
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              //icon: Icon(Icons.time_to_leave),
                                              alignment:
                                                  const AlignmentDirectional(
                                                      1, 0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: Text("Please Login",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium!
                                                      .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary)),
                                              content: Text(
                                                "Please Login to book test",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!,
                                              ),
                                              actions: [
                                                // Define buttons for the AlertDialog
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(const Size(80,
                                                                25)), // Set the desired size
                                                  ),
                                                  child: const Text("Login"),
                                                  onPressed: () {
                                                    globalservice.navigate(
                                                        context,
                                                        const Welcomesignin()); // Close the AlertDialog
                                                  },
                                                ),
                                              ],
                                              actionsAlignment:
                                                  MainAxisAlignment.end,
                                            );
                                          });
                                    }
                                  },
                                  child: !isTestSelected(widget.test)
                                      ? const Text("BOOK")
                                      : const Text("BOOKED"),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    foregroundColor: isTestSelected(widget.test)
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    backgroundColor: isTestSelected(widget.test)
                                        ? Theme.of(context).colorScheme.tertiary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Adjust the border radius as needed
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),

                                      // Set the outline color
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Preperation",
                            style: Theme.of(context).textTheme.headlineMedium),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text("note : ",
                            //     style: Theme.of(context).textTheme.labelLarge),
                            Icon(
                              Icons.food_bank_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("No fasting required.",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Any Queries ?",
                            style: Theme.of(context).textTheme.headlineMedium),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    globalservice.makingPhoneCall("9663383095");
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.call_outlined,
                                        color: Color.fromARGB(255, 48, 158, 77),
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Phone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      )
                                    ],
                                  )),
                              // SizedBox(
                              //   width: 80,
                              // ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    globalservice.sendEmail(
                                        "support@medcaph.com",
                                        "Test Queries",
                                        "Hello medcaph team ,");
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.mail,
                                        color: Color.fromARGB(255, 48, 158, 77),
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Mail",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 248, 240, 240),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(children: [
                      Text(
                        "Know about......",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Divider(
                        color: Colors.grey, // Color of the dots
                        height: 20, // Height of the divider
                        thickness: 1, // Thickness of the divider line
                        indent: 20, // Left margin of the divider
                        endIndent: 20, // Right margin of the divider
                      ),
                      Text(
                        widget.test.testName,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Divider(
                        color: Colors.grey, // Color of the dots
                        height: 20, // Height of the divider
                        thickness: 1, // Thickness of the divider line
                        indent: 20, // Left margin of the divider
                        endIndent: 20, // Right margin of the divider
                      ),
                      Text(
                        //"Aspergillus Fumigatus test helps detect allergies against aspergillus fumigatus, the most common fungus in our environment. This test measures IgE antibodies in the blood against this fungus. Aspergillus Fumigatus test helps detect allergies against aspergillus fumigatus, the most common fungus in our environment. This test measures IgE antibodies in the blood against this fungus.",
                        widget.test.testDes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                )
              ]),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  child: (selectedTest.getSelectedTest.isNotEmpty ||
                          selectedTest.getSelectedPackage.isNotEmpty)
                      ? SlotBookingCard(
                          selectedCount: selectedTest.getSelectedTest.length +
                              selectedTest.getSelectedPackage.length,
                          title: " Test/Package Selected",
                          contentColor: false,
                          height: slotBookingCardHeight,
                          content: Price(
                            finalAmount: selectedTest.totalPriceSum.toString(),
                            discount: selectedTest.discount.toString(),
                            isTotalPricePresent: true,
                            discountedAmount:
                                selectedTest.totalDiscountedPriceSum.toString(),
                          ),
                          subContent: "",
                          hyperLink: false,
                          buttonClicked: () {
                            Order order = selectedOrder.getOrder;

                            Widget widget = order.statusCode == 1
                                ? OrderSummaryScreen()
                                : StepOneToBookTest();

                            globalservice.navigate(context, widget);
                          },
                          expandDetail: () {
                            setState(() {
                              expandDetails = true;
                            });
                          },
                        )
                      : const Card()),
            ),
          ],
        ),
      ),
    );
  }
}
