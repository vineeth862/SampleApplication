import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/order_tracker/step1/step1-screen.dart';
import 'package:sample_application/src/screens/Home/order_tracker/step2/step2-screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../utils/Provider/selected_test_provider.dart';
import '../../../../utils/helper_widgets/slot-booking-card.dart';
import '../step3/step3.dart';

class StepTwoToBookTest extends StatefulWidget {
  @override
  _StepTwoToBookTest createState() => _StepTwoToBookTest();
}

class _StepTwoToBookTest extends State<StepTwoToBookTest> {
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
              "Step 2 ",
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
              currentStep: 2,
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
          StepTwoScreen(),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                child: selectedTest.getSelectedTest.isNotEmpty
                    ? SlotBookingCard(
                        title: "Your Location",
                        content: "Mariyappanapalya",
                        navigate: StepThreeToBookTest(),
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
      ),
    );
  }
}
