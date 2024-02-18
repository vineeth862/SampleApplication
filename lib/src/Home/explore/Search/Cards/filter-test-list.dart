import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/Home/models/test/testcard.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/Home/explore/explore.service.dart';
import 'package:sample_application/src/core/helper_widgets/test_card.dart';
import '../../../../core/Provider/selected_order_provider.dart';
import '../../../../core/Provider/selected_test_provider.dart';
import '../../../../core/helper_widgets/slot-booking-card.dart';
import '../../../models/order/order.dart';
import '../../../models/test/test.dart';
import '../../../order_tracker/order-summary/orderSumaryScreen.dart';
import '../../../order_tracker/step1/step1.dart';

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
  num slotBookingCardHeight = 120;
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
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width < 600 ? 1 : 2,
                      childAspectRatio: MediaQuery.of(context).size.width < 600
                          ? 2.30
                          : 2.37, // number of items in each row
                      mainAxisSpacing: 4.0, // spacing between rows
                      crossAxisSpacing: 16.0, // spacing between columns
                    ),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 5, right: 5),
                        child: TestCardWidget(
                            isTest: true,
                            title: list[index].labName,
                            test: list[index].testObject,
                            cardName: list[index].name,
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
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  child: (selectedTest.getSelectedTest.isNotEmpty ||
                          selectedTest.getSelectedPackage.isNotEmpty)
                      ? SlotBookingCard(
                          selectedCount: selectedTest.getSelectedTest.length +
                              selectedTest.getSelectedPackage.length,
                          title: " Test/Package Selected",
                          contentColor: false,
                          content: "view details",
                          subContent: "",
                          height: slotBookingCardHeight,
                          hyperLink: true,
                          buttonClicked: () {
                            Order order = selectedOrder.getOrder;
                            if (selectedTest!.getSelectedPackage.length == 0 &&
                                selectedTest!.getSelectedTest.length == 0) {
                            } else if (order.statusCode == 1) {
                              Get.off(() => OrderSummaryScreen());
                            } else {
                              globalservice.navigate(
                                  context, StepOneToBookTest());
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
          ],
        ),
      ),
    );
  }
}
