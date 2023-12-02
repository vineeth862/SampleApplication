import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  String headline;

  String title;

  RichTextWidget({
    super.key,
    required this.headline,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
              text: headline + ": ",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          TextSpan(
              text: title, style: Theme.of(context).textTheme.headlineSmall!),
        ],
      ),
    );
  }
}
