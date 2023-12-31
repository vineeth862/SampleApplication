import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/order_tracker/step1/step1-screen.dart';
import 'package:sample_application/src/core/Provider/selected_order_provider.dart';
import 'package:sample_application/src/core/helper_widgets/price_container.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../core/Provider/selected_test_provider.dart';
import '../../../core/globalServices/global_service.dart';
import '../../../core/helper_widgets/slot-booking-card.dart';
import '../step2/step2.dart';

class StepOneToBookTest extends StatefulWidget {
  @override
  _StepOneToBookTest createState() => _StepOneToBookTest();
}

class _StepOneToBookTest extends State<StepOneToBookTest> {
  // Add your state variables and methods here
  bool expandDetails = false;
  GlobalService globalservice = GlobalService();

  @override
  Widget build(BuildContext context) {
    final widget = StepOneScreen();
    final selectedTest = Provider.of<SelectedTestState>(context, listen: true);
    final selectedOrder = Provider.of<SelectedOrderState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
        actions: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Step 1 ",
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
              currentStep: 1,
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
      body: Container(
        height: double.infinity,
        child: Stack(children: [
          widget,
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                child: (selectedTest.getSelectedTest.isNotEmpty ||
                        selectedTest.getSelectedPackage.isNotEmpty)
                    ? SlotBookingCard(
                        selectedCount: selectedTest.getSelectedTest.length +
                            selectedTest.selectedPackage.length,
                        title: " Test/Package Selected",
                        contentColor: false,
                        height: 150,
                        content: Price(
                            finalAmount: selectedTest.totalPriceSum.toString(),
                            discount: selectedTest.discount.toString(),
                            isTotalPricePresent: true,
                            discountedAmount: selectedTest
                                .totalDiscountedPriceSum
                                .toString()),
                        subContent: "",
                        hyperLink: false,
                        buttonClicked: () async {
                          if (await widget.btnClicked()) {
                            globalservice.navigate(
                                context, StepTwoToBookTest());
                          }
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
      ),
    );
  }
}
