import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/screens/Home/models/test/testcard.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/utils/helper_widgets/test_card.dart';
import '../../../../../utils/Provider/selected_order_provider.dart';
import '../../../../../utils/Provider/selected_test_provider.dart';
import '../../../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../../../utils/helper_widgets/slot-booking-card.dart';
import '../../../models/order/order.dart';
import '../../../models/test/test.dart';
import '../../../order_tracker/payment/paymentScreen.dart';
import '../../../order_tracker/step1/step1.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';

class FilteredTestCardlistPage extends StatefulWidget {
  String title;
  String category;

  FilteredTestCardlistPage(
      {super.key, required this.title, required this.category});

  @override
  State<FilteredTestCardlistPage> createState() =>
      _FilteredTestCardlistPageState();
}

class _FilteredTestCardlistPageState extends State<FilteredTestCardlistPage> {
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();

  bool expandDetails = false;

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    final selectedOrder = Provider.of<SelectedOrderState>(context);
    List<TestCard> list = searchState.getTestCardList;

    bool isTestSelected(Test test) {
      return (selectedTest.getSelectedTest
          .where((element) =>
              element.medCapTestCode == test.medCapTestCode &&
              element.labCode == test.labCode)
          .isNotEmpty);
    }

    void onBookButton(Test testObject) {
      if (selectedTest.getSelectedTest.contains(testObject)) {
        selectedTest.removeTest(testObject);
      } else {
        List<Test> duplicateTest = selectedTest.getSelectedTest
            .where((element) =>
                element.medCapTestCode == testObject.medCapTestCode)
            .toList();

        if (duplicateTest.isNotEmpty) {
          selectedTest.removeTest(duplicateTest[0]);
        }
        selectedTest.addTest(testObject);
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: TestCardWidget(
                          title: list[index].labName,
                          test: list[index].testObject,
                          labName: list[index].name,
                          price: list[index].price,
                          isTestSelected:
                              isTestSelected(list[index].testObject),
                          tapOnButton: (test) {
                            onBookButton(list[index].testObject);

                            globalservice.navigate(
                                context, StepOneToBookTest());

                            if (selectedTest.getSelectedTest.isEmpty) {
                              selectedTest.setDetailExpanded(false);
                            }
                          },
                          tapOnCard: (value) {
                            globalservice.navigate(
                                context,
                                CardDetailPage(
                                  test: list[index].testObject,
                                ));
                          }),
                    );
                  },
                ),
              ),
            ],
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
    );
  }
}
