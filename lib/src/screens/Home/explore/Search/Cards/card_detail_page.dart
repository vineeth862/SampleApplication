import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import '../../../../../utils/Provider/selected_test_provider.dart';
import '../../../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../../../utils/helper_widgets/slot-booking-card.dart';
import '../../../models/lab/lab_card.dart';
import '../../../order_tracker/step1/step1.dart';

class CardDetailPage extends StatefulWidget {
  CardDetailPage({super.key, required this.lab});
  LabCard lab;
  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  GlobalService globalservice = GlobalService();
  bool expandDetails = false;
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    List<dynamic> list = searchState.getTestCardList.isEmpty
        ? searchState.getLabCardList
        : searchState.getTestCardList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(176, 113, 187, 1)),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text(
            "Test Details",
            style: TextStyle(color: Color.fromRGBO(176, 113, 187, 1)),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: ListView(children: [
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Information",
                            style: Theme.of(context).textTheme.displayLarge),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("test : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("HIV",
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("lab : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("anandh",
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Sample Required : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("blood, urine",
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Recommended Gender : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("male, female",
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("start at : ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Expanded(
                              child: ListTile(
                                leading: Icon(Icons.currency_rupee,
                                    size: 23, weight: 50, color: Colors.black),
                                horizontalTitleGap: -18.0,
                                title: Text("3564",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedTest.getSelectedTest.contains("03")) {
                                selectedTest.removeTest("03");
                              } else {
                                selectedTest.addTest("03");
                              }
                            },
                            child: !selectedTest.getSelectedTest.contains("03")
                                ? Text("BOOK")
                                : Text("BOOKED"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              foregroundColor: !selectedTest.getSelectedTest
                                      .contains("03")
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background,
                              backgroundColor:
                                  !selectedTest.getSelectedTest.contains("03")
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the border radius as needed
                                side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary), // Set the outline color
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Preperation",
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text("note : ",
                            //     style: Theme.of(context).textTheme.labelLarge),
                            Text("* no preperation required...",
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Need help ?",
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.call_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text("Call our health adviser to book",
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                Text("our team of experts will guid you",
                                    style:
                                        Theme.of(context).textTheme.titleSmall)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: Theme.of(context).cardTheme.shape,
                  color: Theme.of(context).cardTheme.color,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Freequently booked together",
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
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
      ),
    );
  }
}
