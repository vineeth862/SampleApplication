import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/Provider/selected_test_provider.dart';
import '../../Home/models/package/package.dart';
import '../../Home/models/test/test.dart';
import '../../Home/order_tracker/confirmation-allert.dart';
import '../globalServices/global_service.dart';
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
  GlobalService globalservice = GlobalService();
  SearchListState? searchState;
  Test? filteredTest;

  Column generateListTileBodyForTest(Test test) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(test.testName), Text(test.price)],
    );
  }

  Column generateListTileBodyForPackage(Package package) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(package.displayName), Text(package.price.toString())],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
    searchState = Provider.of<SearchListState>(context);

    return Column(
      children: [
        Text(
          "Your Cart",
          style: Theme.of(context).textTheme.headlineMedium,
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
    );
  }
}
