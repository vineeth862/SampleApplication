import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/order_tracker/step1/step1-screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../global_service/global_service.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../../utils/helper_widgets/slot-booking-card.dart';
import '../../explore/Search/search_field.dart';
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
    final selectedTest = Provider.of<SelectedTestState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
        actions: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Step 1 ",
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
            bottom: 100,
            right: 0,
            left: 0,
            child: SwipeableContainer(
                key: UniqueKey(),
                removeTest: (testCode) {
                  setState(() {
                    selectedTest.removeTest(testCode);

                    if (selectedTest.getSelectedTest.isEmpty) {
                      selectedTest.setDetailExpanded(false);
                      this.globalservice.navigate(context, SearchBarPage());
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
                        buttonClicked: () async {
                          await widget.btnClicked();
                          globalservice.navigate(context, StepTwoToBookTest());
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
