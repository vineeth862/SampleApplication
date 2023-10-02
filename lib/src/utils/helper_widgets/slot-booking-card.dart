import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';
import '../../global_service/global_service.dart';

class SlotBookingCard extends StatefulWidget {
  final int selectedCount;
  final String title;
  final dynamic content;
  final bool contentColor;
  final String subContent;
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
      required this.buttonClicked});

  @override
  State<SlotBookingCard> createState() => _SlotBookingCardState();
}

class _SlotBookingCardState extends State<SlotBookingCard> {
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
    return Container(
      height: 120.0,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  ),
                  SizedBox(height: 8.0),
                  widget.hyperLink
                      ? ListTile(
                          contentPadding: EdgeInsets
                              .zero, // Remove the default content padding
                          title: Padding(
                            padding: EdgeInsets.only(
                                left: 5.0), // Adjust the left padding as needed
                            child: Row(
                              children: [
                                Text(
                                  widget.content,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.orangeAccent),
                                ),
                                // SizedBox(width: 4.0),
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            widget.expandDetail();
                            selectedTest.toggelDetailExpanded();
                          })
                      : widget.content is String
                          ? Text(
                              widget.content,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: widget.contentColor
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .inverseSurface),
                            )
                          : widget.content,
                  SizedBox(height: 8.0),
                  Text(widget.subContent)
                ],
              ),
            ),
            SizedBox(width: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.tertiary),
              onPressed: () {
                widget.buttonClicked();
                // this.globalservice.navigate(context, widget.navigate);
                // Button press logic
              },
              child: Text(
                'Proceed',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
