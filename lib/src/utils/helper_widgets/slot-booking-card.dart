import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';
import '../../global_service/global_service.dart';

class SlotBookingCard extends StatefulWidget {
  final String title;
  final String content;
  final Widget navigate;
  final bool hyperLink;
  Function() expandDetail;

  SlotBookingCard(
      {required this.title,
      required this.content,
      required this.navigate,
      required this.hyperLink,
      required this.expandDetail});

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
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
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
                                  style: TextStyle(color: Colors.orange),
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
                      : Text(
                          widget.content,
                          style: TextStyle(fontSize: 16.0),
                        ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: () {
                this.globalservice.navigate(context, widget.navigate);
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
