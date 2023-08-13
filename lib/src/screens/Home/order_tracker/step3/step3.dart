import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/order_tracker/step3/step3-screen.dart';
import 'package:sample_application/src/screens/order/orderSummary.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../../../../utils/helper_widgets/slot-booking-card.dart';
import '../step1/step1.dart';

class StepThreeToBookTest extends StatefulWidget {
  @override
  _StepThreeToBookTest createState() => _StepThreeToBookTest();
}

class _StepThreeToBookTest extends State<StepThreeToBookTest> {
  // Add your state variables and methods here
  bool expandDetails = false;
  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
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
        StepThreeScreen(),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              child: selectedTest.getSelectedTest.isNotEmpty
                  ? SlotBookingCard(
                      title: "Collection at",
                      content: "20th jul| 06:45 AM",
                      navigate: OrderSummaryPage(),
                      hyperLink: false,
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
