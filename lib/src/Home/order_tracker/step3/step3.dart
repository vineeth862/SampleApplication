import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/order/booked.dart';
import 'package:sample_application/src/Home/order_tracker/step3/step3-screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:sample_application/src/Home/models/order/order.dart' as order;
import 'package:intl/intl.dart';

import '../../../core/Provider/selected_order_provider.dart';
import '../../../core/Provider/selected_test_provider.dart';
import '../../../core/globalServices/global_service.dart';
import '../../../core/helper_widgets/slot-booking-card.dart';
import '../../models/package/package.dart';
import '../../models/test/test.dart';
import '../order-summary/orderSumaryScreen.dart';

class StepThreeToBookTest extends StatefulWidget {
  @override
  _StepThreeToBookTest createState() => _StepThreeToBookTest();
}

class _StepThreeToBookTest extends State<StepThreeToBookTest> {
  // Add your state variables and methods here
  bool expandDetails = false;
  String selectedslot = "";
  GlobalService globalservice = GlobalService();
  late Booked booked = Booked(bookedDate: "", bookedSlot: "", slot: "");
  num slotBookingCardHeight = 120;
  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context, listen: true);
    final selectedOrder =
        Provider.of<SelectedOrderState>(context, listen: true);
    order.Order orderObject = selectedOrder.getOrder;

    final screen = StepThreeScreen(
      slotSelected: (date, time, slot) {
        String formattedDate = DateFormat('dd-MM-yyyy').format(date);
        if (slot.isNotEmpty) {
          setState(() {
            booked = Booked(
                bookedDate: formattedDate,
                bookedSlot: slot,
                slot: formattedDate + " " + slot);
          });
          // print(time);
        } else {
          setState(() {
            booked = Booked(
                bookedDate: formattedDate,
                bookedSlot: slot,
                slot: formattedDate);
          });
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
        actions: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Step 3 ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "of 3  ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 50,
            child: StepProgressIndicator(
              roundedEdges: Radius.circular(50),
              unselectedGradientColor: LinearGradient(
                colors: [Colors.grey, Colors.grey],
              ),
              totalSteps: 3,
              currentStep: 3,
              padding: 1,
              size: 6,
              selectedSize: 7.0,
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: Stack(children: [
        screen,
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              child: selectedTest.getSelectedTest.isNotEmpty ||
                      selectedTest.getSelectedPackage.isNotEmpty
                  ? SlotBookingCard(
                      selectedCount: 0,
                      title: "Sample Collection",
                      contentColor: false,
                      content: "Date : " + booked.bookedDate!,
                      subContent: "Slot : " + booked.bookedSlot!,
                      height: slotBookingCardHeight,
                      hyperLink: false,
                      buttonClicked: () async {
                        order.Order orderObject = selectedOrder.getOrder;

                        if (booked.bookedSlot!.isNotEmpty) {
                          orderObject.booked = booked;
                          orderObject.labCode = orderObject.tests!.isNotEmpty
                              ? orderObject.tests![0].labCode
                              : orderObject.packages![0].labCode;
                          orderObject.labName = orderObject.tests!.isNotEmpty
                              ? orderObject.tests![0].labName
                              : orderObject.packages![0].labName;
                          selectedOrder.setOrder = orderObject;

                          await selectedOrder.docInIt();

                          orderObject.statusCode = 1;
                          orderObject.statusLabel = "Payment Pending";

                          int totalAmmount = 0;
                          orderObject.tests!.forEach((Test test) {
                            totalAmmount += int.parse(test.price);
                          });
                          orderObject.packages!.forEach((Package package) {
                            totalAmmount += int.parse(package.price.toString());
                          });
                          orderObject.totalPrice = totalAmmount;

                          orderObject.createdDate =
                              new DateTime.now().toString();
                          selectedOrder.setOrder = orderObject;

                          await selectedOrder.createOrder();
                          Get.off(OrderSummaryScreen());
                        } else {
                          Get.snackbar(
                              "Info", "Please Select Both Date and Time",
                              icon: Icon(
                                Icons.warning_amber_rounded,
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              dismissDirection: DismissDirection.horizontal,
                              forwardAnimationCurve: ElasticInOutCurve(),
                              duration: Duration(seconds: 2)
                              //colorText: Theme.of(context).colorScheme.primary,
                              );
                        }
                        // OrderSummaryScreen()
                      },
                      expandDetail: () {
                        setState(() {
                          expandDetails = true;
                        });
                      },
                    )
                  : Card()),
        ),
      ]),
    );
  }
}
