import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';

import '../../global_service/global_service.dart';
import '../../screens/Home/explore/Search/Cards/filter-lab-list.dart';
import '../../screens/Home/models/package/package.dart';
import '../../screens/Home/order_tracker/step1/confirmation-allert.dart';
import '../Provider/search_provider.dart';

class SwipeableContainer extends StatefulWidget {
  SwipeableContainer(
      {super.key, required this.removeTest, required this.removePackage});
  Function(Test testCode) removeTest;
  Function(Package testCode) removePackage;
  @override
  _SwipeableContainerState createState() => _SwipeableContainerState();
}

class _SwipeableContainerState extends State<SwipeableContainer> {
  double _swipeStartY = 0.0;
  GlobalService globalservice = GlobalService();
  SearchListState? searchState;
  Test? filteredTest;
  void _onVerticalDragStart(DragStartDetails details) {
    _swipeStartY = details.globalPosition.dy;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _swipeStartY = 0.0;
    });
  }

  Column generateListTileBodyForTest(Test test) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(test.testName), Text(test.price)],
    );
  }

  Column generateListTileBodyForPackage(Package package) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(package.displayName), Text(package.price)],
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
                      .displayLarge!
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
                              title: generateListTileBodyForTest(test),
                              iconColor: Theme.of(context).colorScheme.primary,
                              leading: Icon(Icons.medical_services),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.removeTest(test);
                                    });
                                  },
                                  icon: Icon(Icons.delete_outlined)),
                            ),
                          )
                          .toList(),
                      ...selectedTest.getSelectedPackage
                          .map(
                            (package) => ListTile(
                              title: generateListTileBodyForPackage(package),
                              iconColor: Theme.of(context).colorScheme.primary,
                              leading: Icon(Icons.medical_services),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.removePackage(package);
                                    });
                                  },
                                  icon: Icon(Icons.delete_outlined)),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () async {
                    // if (selectedTest.getSelectedTest.isNotEmpty ||
                    //     selectedTest.getSelectedPackage.isNotEmpty) {
                    //   var lab = selectedTest.getSelectedTest[0];
                    //   await searchState?.cardClicked(lab.labCode, false);
                    //   this.globalservice.navigate(
                    //       context,
                    //       FilteredLabCardlistPage(
                    //         title: lab.labName,
                    //         labCode: lab.labCode,
                    //         location: "location",
                    //       ));
                    // }
                    // setState(() {
                    //   selectedTest.toggelDetailExpanded();
                    // });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Allert(),
                        ); // Custom widget for the dialog content
                      },
                    );
                  },
                  title: Text(
                    "Add more Items",
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
