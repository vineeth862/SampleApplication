import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/order_tracker/step1/confirmation-allert.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import '../../../../../utils/Provider/selected_order_provider.dart';
import '../../../../../utils/Provider/selected_test_provider.dart';
import '../../../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../../../utils/helper_widgets/slot-booking-card.dart';
import '../../../models/order/order.dart';
import '../../../order_tracker/payment/paymentScreen.dart';
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
    List<dynamic> list = searchState.getTestCardList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "Test Details",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Color.fromRGBO(219, 229, 233, 1),
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
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(
                          height: 20,
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
                                    Theme.of(context).textTheme.headlineMedium),
                            Text(widget.test.labName,
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Sample Required : ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            Text(widget.test.sampletypeName,
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Method : ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            Text("Not Specified",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Text("start at : ",
                        //         style: Theme.of(context).textTheme.labelLarge),
                        //     Expanded(
                        //       child: ListTile(
                        //         leading: Icon(Icons.currency_rupee,
                        //             size: 21, weight: 45, color: Colors.black),
                        //         horizontalTitleGap: -18.0,
                        //         title: Text(widget.test.price,
                        //             textAlign: TextAlign.left,
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .labelLarge
                        //                 ?.copyWith(
                        //                     color: Colors.black,
                        //                     fontSize: 22,
                        //                     fontWeight: FontWeight.bold)),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        // Container(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       String userKey =
                        //           globalservice.getCurrentUserKey();
                        //       if (userKey != "null") {
                        //         if (selectedTest.getSelectedTest
                        //             .contains(widget.test)) {
                        //           selectedTest.removeTest(widget.test);
                        //         } else {
                        //           selectedTest.addTest(widget.test);
                        //         }
                        //       } else {
                        //         showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return AlertDialog(
                        //                 //icon: Icon(Icons.time_to_leave),
                        //                 alignment:
                        //                     const AlignmentDirectional(1, 0),
                        //                 shape: RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(10)),
                        //                 title: Text("Please Login",
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .displayLarge!
                        //                         .copyWith(
                        //                             color: Theme.of(context)
                        //                                 .colorScheme
                        //                                 .primary)),
                        //                 content: Text(
                        //                   "Please Login to book test",
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .titleMedium!,
                        //                 ),
                        //                 actions: [
                        //                   // Define buttons for the AlertDialog
                        //                   ElevatedButton(
                        //                     style: ButtonStyle(
                        //                       minimumSize: MaterialStateProperty
                        //                           .all(const Size(80,
                        //                               25)), // Set the desired size
                        //                     ),
                        //                     child: const Text("Login"),
                        //                     onPressed: () {
                        //                       globalservice.navigate(context,
                        //                           const Welcomesignin()); // Close the AlertDialog
                        //                     },
                        //                   ),
                        //                 ],
                        //                 actionsAlignment: MainAxisAlignment.end,
                        //               );
                        //             });
                        //       }
                        //     },
                        //     child: !selectedTest.getSelectedTest
                        //             .contains(widget.test)
                        //         ? Text("BOOK")
                        //         : Text("BOOKED"),
                        //     style: ElevatedButton.styleFrom(
                        //       padding: EdgeInsets.all(0),
                        //       foregroundColor: !selectedTest.getSelectedTest
                        //               .contains(widget.test)
                        //           ? Theme.of(context).colorScheme.primary
                        //           : Theme.of(context).colorScheme.background,
                        //       backgroundColor: !selectedTest.getSelectedTest
                        //               .contains(widget.test)
                        //           ? Theme.of(context).colorScheme.onPrimary
                        //           : Theme.of(context).colorScheme.primary,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(
                        //             8.0), // Adjust the border radius as needed
                        //         side: BorderSide(
                        //             color: Theme.of(context)
                        //                 .colorScheme
                        //                 .primary), // Set the outline color
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                            style: Theme.of(context).textTheme.bodyLarge),
                        SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
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
                            SizedBox(
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
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("Tapped");
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.call_outlined,
                                      color: Color.fromARGB(255, 48, 108, 158),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Phone",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    )
                                  ],
                                )),
                            SizedBox(
                              width: 80,
                            ),
                            GestureDetector(
                                onTap: () {
                                  print("Tapped");
                                },
                                child: Column(
                                  children: [
                                    Icon(Icons.mail,
                                        color:
                                            Color.fromARGB(255, 48, 108, 158)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Mail",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    )
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 80,
                    //width: double.infinity,
                    // decoration: BoxDecoration(
                    //     gradient: LinearGradient(colors: [
                    //   Theme.of(context).colorScheme.surface,
                    //   Theme.of(context).colorScheme.surface
                    // ])),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 253, 245, 229),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Price: ₹" + widget.test.price,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String userKey = globalservice.getCurrentUserKey();
                            if (userKey != "null") {
                              if (selectedTest.getSelectedTest
                                  .contains(widget.test)) {
                                selectedTest.removeTest(widget.test);
                              } else {
                                selectedTest.addTest(widget.test);
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      //icon: Icon(Icons.time_to_leave),
                                      alignment:
                                          const AlignmentDirectional(1, 0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      title: Text("Please Login",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
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
                                            minimumSize: MaterialStateProperty
                                                .all(const Size(80,
                                                    25)), // Set the desired size
                                          ),
                                          child: const Text("Login"),
                                          onPressed: () {
                                            globalservice.navigate(context,
                                                const Welcomesignin()); // Close the AlertDialog
                                          },
                                        ),
                                      ],
                                      actionsAlignment: MainAxisAlignment.end,
                                    );
                                  });
                            }
                          },
                          child: !selectedTest.getSelectedTest
                                  .contains(widget.test)
                              ? Text("BOOK")
                              : Text("BOOKED"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            foregroundColor: !selectedTest.getSelectedTest
                                    .contains(widget.test)
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            backgroundColor: !selectedTest.getSelectedTest
                                    .contains(widget.test)
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust the border radius as needed
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),

                              // Set the outline color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Positioned(
              bottom: 100,
              right: 0,
              left: 0,
              child: SwipeableContainer(
                  key: UniqueKey(),
                  removeTest: (tesCode) {
                    selectedTest.removeTest(tesCode);
                    if (selectedTest.getSelectedTest.isEmpty &&
                        selectedTest.getSelectedPackage.isEmpty) {
                      selectedTest.setDetailExpanded(false);
                    }
                  },
                  removePackage: (pacCode) {
                    selectedTest.removePackage(pacCode);
                    if (selectedTest.getSelectedTest.isEmpty &&
                        selectedTest.getSelectedPackage.isEmpty) {
                      selectedTest.setDetailExpanded(false);
                    }
                  }),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  child: (selectedTest.getSelectedTest.isNotEmpty ||
                          selectedTest.getSelectedPackage.isNotEmpty)
                      ? SlotBookingCard(
                          title:
                              "${selectedTest.getSelectedTest.length + selectedTest.getSelectedPackage.length} item Selected",
                          content: "view details",
                          hyperLink: true,
                          buttonClicked: () {
                            Order order = selectedOrder.getOrder;

                            Widget widget = order.statusCode == 1
                                ? PaymentScreeen()
                                : StepOneToBookTest();

                            globalservice.navigate(context, widget);
                          },
                          expandDetail: () {
                            setState(() {
                              expandDetails = true;
                            });
                          },
                        )
                      : Card()),
            ),
          ],
        ),
      ),
    );
  }
}
