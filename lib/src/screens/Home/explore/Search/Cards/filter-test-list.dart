import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/screens/Home/models/test/test_card.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/utils/helper_widgets/test_card.dart';
import '../../../../../utils/Provider/selected_test_provider.dart';
import '../../../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../../../utils/helper_widgets/slot-booking-card.dart';
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
  bool expandDetails = false;
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    List<TestCard> list = searchState.getTestCardList;
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
                  padding: const EdgeInsets.all(10),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TestCardWidget(
                        title: list[index].name,
                        description: list[index].test.toString(),
                        labName: list[index].labName,
                        price: list[index].price,
                        isTestSelected: !selectedTest.getSelectedTest
                            .contains(list[index]?.testObject),
                        tapOnButton: (test) {
                          if (selectedTest.getSelectedTest
                              .contains(list[index]?.testObject))
                            selectedTest.removeTest(list[index]?.testObject);
                          else
                            selectedTest.addTest(list[index]?.testObject);

                          globalservice.navigate(context, StepOneToBookTest());

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
                        });
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
                          GlobalService().navigate(
                            context,
                            StepOneToBookTest(),
                          );
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
