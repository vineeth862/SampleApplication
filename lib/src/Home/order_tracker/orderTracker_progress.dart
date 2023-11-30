import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/Provider/selected_test_provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/core/helper_widgets/price_container.dart';
import 'package:sample_application/src/core/helper_widgets/richTextWidget.dart';
import '../../core/Provider/loading_provider.dart';
import '../../core/Provider/selected_order_provider.dart';
import '../models/status/status.dart';
import 'order-summary/orderTrackerDailog.dart';

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
  //int step = 0;
  int _currentStep = 0;
  num statusCode = 0;
  _OrderTrackingScreenState({this.order});
  // loadData() async {
  //   await selectedOrder.fetchStatus(order!.statusCode);
  //   setState(() {
  //     status = selectedOrder.getStatus;
  //     step = status!.step!.toInt();
  //     statusCode = status!.step!.toInt();
  //     _currentStep = step;
  //     loadingProvider.stopLoading();
  //   });
  // }
  void updateStatusCode() async {
    await selectedOrder.fetchStatus(order!.statusCode);
    status = selectedOrder.getStatus;
    statusCode = status!.statusCode!;
    if (status!.statusCode! <= 2) {
      setState(() {
        _currentStep = 0;
      });
    }
    if (status!.statusCode! <= 3) {
      setState(() {
        _currentStep = 1;
      });
    }
    if (status!.statusCode! < 12) {
      setState(() {
        _currentStep = 2;
      });
    }
    loadingProvider.stopLoading();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
      selectedOrder = Provider.of<SelectedOrderState>(context, listen: false);
      loadingProvider.startLoading();
      this.updateStatusCode();
    });
  }

  String getTechnicianName(technician) {
    return technician != null ? technician['name'] : ' - ';
  }

  String getTechnicianMob(technician) {
    return technician != null ? technician['phone'] : ' - ';
  }

  void proceedToNextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        // Handle completion or take appropriate action
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(colors: [
            //       Theme.of(context).colorScheme.tertiary,
            //       Theme.of(context).colorScheme.tertiary,
            //     ]),
            //   ),
            //   child: ListTile(
            //     title: Text("Status: ",
            //         style: Theme.of(context).textTheme.headlineMedium!),
            //     subtitle: Text(
            //       order!.statusLabel.toString(),
            //       style: Theme.of(context).textTheme.headlineMedium,
            //     ),
            //   ),
            // ),

            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "OrderID: ",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    subtitle: Text(
                      order!.orderNumber.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OrderTrackerDialog(
                            order: order!,
                          ); // Custom widget for the dialog content
                        },
                      );
                    },
                    child: Text("Order Overview"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // <-- Radius
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(status!.statusLabel.toString(),
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Container(
              //width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Stepper(
                onStepContinue: () {
                  proceedToNextStep();
                },
                onStepCancel: () {
                  setState(() {
                    if (_currentStep > 0) {
                      _currentStep -= 1;
                    } else {
                      _currentStep = 0;
                    }
                  });
                },
                steps: [
                  Step(
                      //subtitle: const Text('Order'),
                      label: Text('Order Details'),
                      title: Text(''),
                      //title: const Text('Order'),
                      // content: Step1Widget(
                      //     orderObj: widget.orderObj,
                      //     details: proceedToNextStep),
                      content: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                //border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RichTextWidget(
                                          headline: "Full Name",
                                          title: order!.patient == null
                                              ? order!.user!.userName.toString()
                                              : order!.patient!.userName
                                                  .toString()),
                                      Spacer(),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          order!.booked!.slot.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // <-- Radius
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .tertiary
                                                .withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                  RichTextWidget(
                                      headline: "Address",
                                      title: order!.address.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichTextWidget(
                                      headline: "Mobile Number",
                                      title: order!.patient == null
                                          ? order!.user!.mobile.toString()
                                          : order!.patient!.mobile.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichTextWidget(
                                      headline: "Date",
                                      title: order!.createdDate
                                          .toString()
                                          .substring(0, 10)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.2),
                              //border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: RichTextWidget(
                                      headline: "Lab",
                                      title: order!.labName.toString(),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // <-- Radius
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.8)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Booked Test/Packages:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                order!.tests!.isNotEmpty
                                    ? Container(
                                        //height: 100,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: order!.tests!.length,
                                          itemBuilder: (context, index) {
                                            // return ListTile(
                                            //   leading: Text(
                                            //     (index + 1).toString() + " -->",
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .headlineSmall,
                                            //   ),
                                            //   title: Text(order!
                                            //       .tests![index].testName),
                                            // );
                                            return ListTile(
                                              title: Text(
                                                  (index + 1).toString() +
                                                      " : " +
                                                      order!.tests![index]
                                                          .testName),
                                              subtitle: Price(
                                                isTotalPricePresent: false,
                                                finalAmount:
                                                    order!.tests![index].price,
                                                discount: order!
                                                    .tests![index].discount,
                                                discountedAmount: order!
                                                    .tests![index]
                                                    .discountedPrice,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                      isActive: statusCode >= 3,
                      state: statusCode >= 3
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                      label: const Text('Payments'),
                      title: Text(""),
                      // content: Step2Widget(
                      //     orderObj: widget.orderObj,
                      //     details: proceedToNextStep),
                      content: Container(child: Text("Step 2")),
                      isActive: statusCode >= 3,
                      state: statusCode >= 3
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                      label: const Text('Plebo Details'),
                      title: Text(""),
                      // content: Step2Widget(
                      //     orderObj: widget.orderObj,
                      //     details: proceedToNextStep),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Medcaph Verified Phlebotomist",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    leading: Icon(
                                      Icons.verified,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  RichTextWidget(
                                      headline: "Assigned Plebo",
                                      title:
                                          order!.technician!.name.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichTextWidget(
                                      headline: "Plebo Contact",
                                      title:
                                          order!.technician!.phone.toString()),
                                  // Divider(
                                  //   thickness: 0.6,
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Feed Back for plebo",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              labelText: 'Please give feedback',
                              //hintText: 'Enter Your Name',
                            ),
                          ),
                          Center(
                            child: OutlinedButton(
                                onPressed: () {}, child: Text("Submit")),
                          )
                        ],
                      ),
                      isActive: statusCode >= 6,
                      state: statusCode >= 6
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                      label: const Text('Report'),
                      title: Text(""),
                      // content: Step3Widget(
                      //     orderObj: widget.orderObj,
                      //     details: proceedToNextStep),
                      content: Container(child: Text("Step 1")),
                      isActive: _currentStep >= 3,
                      state: _currentStep > 3
                          ? StepState.complete
                          : StepState.disabled),
                  // Step(
                  //     title: Text(''),
                  //     content: steps[3],
                  //     isActive: _currentStep >= 3,
                  //     state:
                  //         _currentStep > 3 ? StepState.complete : StepState.disabled),
                ],
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepTapped: (step) {
                  setState(() {
                    _currentStep = step;
                  });
                },
                controlsBuilder: controlsBuilder,
              ),
            ),
            // Expanded(
            //   child: Stepper(
            //     controlsBuilder: (context, controller) {
            //       return const SizedBox.shrink();
            //     },
            //     currentStep: currentStep,
            //     onStepTapped: (int index) {
            //       setState(() {
            //         if (index <= step) {
            //           currentStep = index;
            //         }
            //         // _index = index;
            //       });
            //     },
            //     steps: <Step>[
            //       Step(
            //         isActive: step >= 0,
            //         title: Text('Order Placed'),
            //         content: Container(
            //           alignment: Alignment.centerLeft,
            //           child: Column(
            //             children: [
            //               ListTile(
            //                 title: Text("Order Created Date :"),
            //                 subtitle: Text(order!.createdDate.toString()),
            //               ),
            //               ListTile(
            //                 title: Text("Booked Slot Time :"),
            //                 subtitle: Text(order!.booked!.slot.toString()),
            //               ),
            //               ListTile(
            //                 title: Text("Booked Address :"),
            //                 subtitle: Text(order!.address.toString()),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Step(
            //         isActive: step >= 1,
            //         title: Text('Payment Status'),
            //         content: Container(
            //           alignment: Alignment.centerLeft,
            //           child: Column(
            //             children: [
            //               // ListTile(
            //               //   title: Text("Transaction Status:"),
            //               //   subtitle: Text(order!.statusLabel.toString()),
            //               // ),
            //               ListTile(
            //                 title: Text("Total Amount:"),
            //                 subtitle: Text(order!.totalPrice.toString()),
            //               ),
            //               ListTile(
            //                 title: Text("Transaction Time:"),
            //                 subtitle: Text("need To update"),
            //               ),
            //               ListTile(
            //                 title: Text("Transaction Id:"),
            //                 subtitle: Text("need to update"),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Step(
            //         isActive: step >= 2,
            //         title: Text('Technician Status'),
            //         content: Container(
            //           alignment: Alignment.centerLeft,
            //           child: Column(
            //             children: [
            //               // ListTile(
            //               //   title: Text("Carrier Status:"),
            //               //   subtitle: Text(order!.statusLabel.toString()),
            //               // ),
            //               ListTile(
            //                 title: Text("Technician Name:"),
            //                 subtitle:
            //                     Text(getTechnicianName(order!.technician)),
            //               ),
            //               ListTile(
            //                 title: Text("Technician mob:"),
            //                 subtitle: Text(getTechnicianMob(order!.technician)),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Step(
            //         isActive: step >= 3,
            //         title: Text('Sample Status'),
            //         content: Container(
            //           alignment: Alignment.centerLeft,
            //           child: Column(
            //             children: [
            //               // ListTile(
            //               //   title: Text("Sample Status:"),
            //               //   subtitle: Text(order!.statusLabel.toString()),
            //               // ),
            //               ListTile(
            //                 title: Text(" Sample Collected Date:"),
            //                 subtitle: Text(order!.createdDate.toString()),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Step(
            //         isActive: step >= 4,
            //         title: Text('Report Status'),
            //         content: Container(
            //           alignment: Alignment.centerLeft,
            //           child: Column(
            //             children: [
            //               ListTile(
            //                   leading: Icon(Icons.download),
            //                   title: Text("download"))
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //OutlinedButton(onPressed: () {}, child: HomePage())
            Divider(
              thickness: 2,
            ),
            // Center(
            //     child: ElevatedButton(
            //         onPressed: () {
            //           globalservice.navigate(context, HomePage());
            //         },
            //         child: Text("Return to Homepage"))),
            // Divider(
            //   thickness: 2,
            // ),
          ],
        ),
      ),
    );
  }
}

Widget controlsBuilder(BuildContext context, ControlsDetails details) {
  return const Card();
}
