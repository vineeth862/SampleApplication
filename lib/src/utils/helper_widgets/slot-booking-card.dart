import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';
import '../../global_service/global_service.dart';
import '../../screens/Home/explore/Search/search_field.dart';
import '../../screens/Home/models/package/package.dart';
import '../../screens/Home/models/test/test.dart';
import '../../screens/Home/order_tracker/confirmation-allert.dart';
import '../../screens/Home/package/package-suggetion-list.dart';

class SlotBookingCard extends StatefulWidget {
  final int selectedCount;
  final String title;
  final dynamic content;
  final bool contentColor;
  final String subContent;
  final num height;
  // final Widget navigate;
  final bool hyperLink;
  Function() expandDetail;
  Function() buttonClicked;

  SlotBookingCard(
      {required this.title,
      required this.content,
      required this.subContent,
      required this.selectedCount,
      required this.hyperLink,
      required this.expandDetail,
      required this.contentColor,
      required this.buttonClicked,
      required this.height});

  @override
  State<SlotBookingCard> createState() => _SlotBookingCardState();
}

class _SlotBookingCardState extends State<SlotBookingCard> {
  bool detailsExpanded = false;
  GlobalService globalservice = GlobalService();
  late SelectedTestState selectedTest;
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
    selectedTest = Provider.of<SelectedTestState>(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(2, 0),
                color: Color.fromARGB(196, 178, 173, 177))
          ]),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                getHeaddingText(),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.tertiary),
                  onPressed: () {
                    widget.buttonClicked();
                  },
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 8.0),
            Divider(),
            getContent(),
            detailsExpanded ? getDetails() : Container()
          ],
        ),
      ),
    );
  }

  getHyperLinkText() {
    return !detailsExpanded
        ? Row(
            children: [
              Text(
                "Details",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14, color: Theme.of(context).colorScheme.primary),
              ),
              // SizedBox(width: 4.0),
              Icon(Icons.keyboard_arrow_down_outlined,
                  color: Theme.of(context).colorScheme.primary),
            ],
          )
        : Row(
            children: [
              Text(
                "Details",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14, color: Theme.of(context).colorScheme.primary),
              ),
              // SizedBox(width: 4.0),
              Icon(Icons.keyboard_arrow_up_outlined,
                  color: Theme.of(context).colorScheme.primary),
              Spacer(),
              Text(
                "Your Cart",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
            ],
          );
  }

  getHeaddingText() {
    return Row(
      children: [
        widget.selectedCount != 0
            ? Text(
                widget.selectedCount.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
              )
            : Text(""),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  getContent() {
    return Column(
      children: [
        widget.hyperLink
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    detailsExpanded = !detailsExpanded;
                  });
                },
                child: getHyperLinkText(),
              )
            : widget.content is String
                ? Text(
                    widget.content,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: widget.contentColor
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.inverseSurface),
                  )
                : widget.content,
        SizedBox(height: 8.0),
        widget.subContent.isNotEmpty ? Text(widget.subContent) : Container(),
      ],
    );
  }

  getDetails() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ...selectedTest!.getSelectedTest
            .map(
              (test) => ListTile(
                title: generateListTileBodyForTest(test),
                iconColor: Theme.of(context).colorScheme.primary,
                leading: ClipOval(
                  child: Container(
                    width: 20,
                    height: 30,
                    //color: Theme.of(context).colorScheme.tertiary,
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.black)),
                    child: Image.asset(
                      "./assets/images/blood-test.png",
                      // scale: 1,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {
                      selectedTest!.removeTest(test);
                      if ((selectedTest!.getSelectedPackage.length == 0 &&
                          selectedTest!.getSelectedTest.length == 0)) {
                        this.globalservice.navigate(context, SearchBarPage());
                      }
                    },
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    )),
              ),
            )
            .toList(),
        ...selectedTest!.getSelectedPackage
            .map(
              (package) => ListTile(
                title: generateListTileBodyForPackage(package),
                iconColor: Theme.of(context).colorScheme.primary,
                leading: Icon(Icons.medical_services),
                trailing: IconButton(
                    onPressed: () {
                      selectedTest!.removePackage(package);
                      if ((selectedTest!.getSelectedPackage.length == 0 &&
                          selectedTest!.getSelectedTest.length == 0)) {
                        this.globalservice.navigate(
                            context, PackageSuggetionList(labCode: ""));
                      }
                    },
                    icon: Icon(Icons.delete_outlined)),
              ),
            )
            .toList(),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Allert(),
                ); // Custom widget for the dialog content
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Add more Items",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
