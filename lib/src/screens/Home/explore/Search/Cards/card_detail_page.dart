import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
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
              const IconThemeData(color: Color.fromRGBO(176, 113, 187, 1)),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text(
            "Test Details",
            style: TextStyle(color: Color.fromRGBO(176, 113, 187, 1)),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: ListView(children: [
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Information",
                            style: Theme.of(context).textTheme.displayLarge),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("test : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Expanded(
                              child: Text(widget.test.testName,
                                  maxLines: 2,
                                  softWrap: true,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("lab : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text(widget.test.labName,
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Sample Required : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text(widget.test.sampletypeName,
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Recommended Gender : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("male, female",
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("start at : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Expanded(
                              child: ListTile(
                                leading: Icon(Icons.currency_rupee,
                                    size: 21, weight: 45, color: Colors.black),
                                horizontalTitleGap: -18.0,
                                title: Text(widget.test.price,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              String userKey =
                                  globalservice.getCurrentUserKey();
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
                                                .displayLarge!
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary), // Set the outline color
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text("note : ",
                            //     style: Theme.of(context).textTheme.labelLarge),
                            Text("* no preperation required...",
                                style: Theme.of(context).textTheme.titleSmall)
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
                        Text("Need help ?",
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.call_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text("Call our health adviser to book",
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                Text("our team of experts will guid you",
                                    style:
                                        Theme.of(context).textTheme.titleSmall)
                              ],
                            )
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
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Freequently booked together",
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
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
                    setState(() {
                      selectedTest.removeTest(tesCode);
                      if (selectedTest.getSelectedTest.isEmpty) {
                        selectedTest.setDetailExpanded(false);
                      }
                    });
                  }),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  child: selectedTest.getSelectedTest.isNotEmpty
                      ? SlotBookingCard(
                          title:
                              "${selectedTest.getSelectedTest.length} item Selected",
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
