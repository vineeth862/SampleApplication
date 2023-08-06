import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';

import '../../global_service/global_service.dart';
import '../../screens/Home/explore/Search/Cards/filtered_list.dart';
import '../../screens/Home/models/lab/lab_card.dart';
import '../Provider/search_provider.dart';

class SwipeableContainer extends StatefulWidget {
  SwipeableContainer({super.key});
  @override
  _SwipeableContainerState createState() => _SwipeableContainerState();
}

class _SwipeableContainerState extends State<SwipeableContainer> {
  double _swipeStartY = 0.0;
  GlobalService globalservice = GlobalService();
  SearchListState? searchState;
  LabCard? filteredTest;
  void _onVerticalDragStart(DragStartDetails details) {
    _swipeStartY = details.globalPosition.dy;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _swipeStartY = 0.0;
    });
  }

  Column generateListTileBody(test) {
    filteredTest = searchState!.filteredLabCardList
        .where((element) => element.testCode.toString() == test)
        .elementAt(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(filteredTest!.name), Text("135")],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
    searchState = Provider.of<SearchListState>(context);
    void _onVerticalDragUpdate(DragUpdateDetails details) {
      double dy = details.globalPosition.dy;
      double delta = dy - _swipeStartY;

      if (delta > 20) {
        // Swiping down
        setState(() {
          selectedTest.toggelDetailExpanded();
        });
      }
    }

    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: selectedTest.isDetailExpanded ? 300.0 : 0.0,
        child: Container(
          height: 320.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: selectedTest.isDetailExpanded ? 2 : 0,
                    blurRadius: selectedTest.isDetailExpanded ? 3 : 0,
                    offset: selectedTest.isDetailExpanded
                        ? const Offset(2, 0)
                        : Offset.zero,
                    color: const Color.fromARGB(196, 178, 173, 177))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Your Cart",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...selectedTest.getSelectedTest
                          .map(
                            (test) => ListTile(
                              title: generateListTileBody(test),
                              iconColor: Theme.of(context).colorScheme.primary,
                              leading: Icon(Icons.medical_services),
                              trailing: IconButton(
                                  onPressed: () {
                                    selectedTest
                                        .removeTest(filteredTest!.testCode);
                                  },
                                  icon: Icon(Icons.delete_outlined)),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    this.globalservice.navigate(
                        context,
                        FilteredCardlistPage(
                          category: 'test',
                          title: "test",
                        ));
                    setState(() {
                      selectedTest.toggelDetailExpanded();
                    });
                  },
                  title: Text(
                    "Add more test",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: Icon(Icons.add_circle_outline),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}