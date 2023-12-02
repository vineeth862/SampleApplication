import 'package:flutter/material.dart';

import '../globalServices/global_service.dart';

class Link extends StatelessWidget {
  final String text;
  final Widget navigate;

  Link({required this.text, required this.navigate});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalservice.navigate(context, navigate);
      },
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Icon(
            Icons.arrow_circle_down_outlined,
            size: 12.0, // Adjust the size as needed.
            color: Theme.of(context)
                .colorScheme
                .primary, // Change the color to match your design.
          ),
        ],
      ),
    );
  }
}
