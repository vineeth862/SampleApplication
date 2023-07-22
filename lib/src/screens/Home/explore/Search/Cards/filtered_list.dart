import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/utils/helper_widgets/lab_card.dart';
import '../../../../../utils/Provider/selected_test_provider.dart';
import '../../../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../../../utils/helper_widgets/slot-booking-card.dart';
import '../../../order_tracker/step1/step1.dart';

class FilteredCardlistPage extends StatefulWidget {
  String title;
  String category;

  FilteredCardlistPage(
      {super.key, required this.title, required this.category});

  @override
  State<FilteredCardlistPage> createState() => _FilteredCardlistPageState();
}

class _FilteredCardlistPageState extends State<FilteredCardlistPage> {
  ExploreService exploreService = ExploreService();

  GlobalService globalservice = GlobalService();
  bool expandDetails = false;
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    List<dynamic> list = searchState.getTestCardList.isEmpty
        ? searchState.getLabCardList
        : searchState.getTestCardList;
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
                    return LabCardWidget(
                        title: list[index].name,
                        description: list[index].test.toString(),
                        isTestSelected: !selectedTest.getSelectedTest
                            .contains(list[index].testCode),
                        tapOnButton: (test) {
                          if (selectedTest.getSelectedTest
                              .contains(list[index].testCode))
                            selectedTest.removeTest(list[index].testCode);
                          else
                            selectedTest.addTest(list[index].testCode);

                          if (selectedTest.getSelectedTest.isEmpty) {
                            selectedTest.setDetailExpanded(false);
                          }
                        },
                        tapOnCard: (value) {
                          globalservice.navigate(
                              context,
                              CardDetailPage(
                                lab: list[index],
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
            child: SwipeableContainer(key: UniqueKey()),
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
                        navigate: StepOneToBookTest(),
                        hyperLink: true,
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
