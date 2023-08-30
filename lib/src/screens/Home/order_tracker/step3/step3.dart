import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/order/booked.dart';
import 'package:sample_application/src/screens/Home/order_tracker/step3/step3-screen.dart';
import 'package:sample_application/src/screens/Home/order_tracker/order-summary/orderSummary.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../../global_service/global_service.dart';
import '../../../../utils/Provider/selected_order_provider.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../../../../utils/helper_widgets/slot-booking-card.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart'
    as order;

class StepThreeToBookTest extends StatefulWidget {
  @override
  _StepThreeToBookTest createState() => _StepThreeToBookTest();
}

class _StepThreeToBookTest extends State<StepThreeToBookTest> {
  // Add your state variables and methods here
  bool expandDetails = false;
  String selectedslot = "";
  GlobalService globalservice = GlobalService();
  late Booked booked;
  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context, listen: true);
    final selectedOrder =
        Provider.of<SelectedOrderState>(context, listen: true);
    order.Order orderObject = selectedOrder.getOrder;

    final screen = StepThreeScreen(
      slotSelected: (date, time) {
        if (time != null) {
          setState(() {
            selectedslot = date.year.toString() +
                "-" +
                date.month.toString() +
                "-" +
                date.day.toString() +
                "  " +
                time!.hour.toString() +
                " : " +
                "00";
            booked = Booked(
                bookedDate: date.toString(),
                bookedSlot: time.hour.toString() + ":" + time.minute.toString(),
                slot: selectedslot);
          });
          // print(time);
        } else {
          setState(() {
            selectedslot = date.year.toString() +
                "-" +
                date.month.toString() +
                "-" +
                date.day.toString();

            booked = Booked(
                bookedDate: date.toString(),
                bookedSlot: time.toString(),
                slot: selectedslot);
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
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "of 3  ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
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
              child: selectedTest.getSelectedTest.isNotEmpty
                  ? SlotBookingCard(
                      title: "Collection at",
                      content: selectedslot,
                      hyperLink: false,
                      buttonClicked: () async {
                        order.Order orderObject = selectedOrder.getOrder;

                        if (selectedslot.split("  ").length == 2) {
                          orderObject.booked = booked;
                          selectedOrder.setOrder = orderObject;

                          await selectedOrder.docInIt();
                          this
                              .globalservice
                              .navigate(context, OrderSummaryPage());
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
                        // OrderSummaryPage()
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
