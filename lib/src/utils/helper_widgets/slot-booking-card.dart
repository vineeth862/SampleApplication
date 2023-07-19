import 'package:flutter/material.dart';

import '../../global_service/global_service.dart';

class SlotBookingCard extends StatelessWidget {
  final String title;
  final String content;
  final Widget navigate;
  GlobalService globalservice = GlobalService();
  SlotBookingCard(
      {required this.title, required this.content, required this.navigate});
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: () {
                this.globalservice.navigate(context, navigate);
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
