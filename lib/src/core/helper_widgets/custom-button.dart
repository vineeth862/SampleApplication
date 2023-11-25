import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isElevated;
  final VoidCallback? onPressed;
  final String text;
  final Color? primaryColor;
  final Color? textColor;
  final Color? borderColor;
  final double? padding;
  final double? borderRadius;

  CustomButton({
    required this.isElevated,
    this.onPressed,
    required this.text,
    this.primaryColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isElevated,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          textStyle: TextStyle(color: textColor),
          padding: EdgeInsets.all(padding ?? 0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0)),
        ),
        child: Text(text),
      ),
      replacement: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: borderColor ?? Theme.of(context).colorScheme.primary),
          textStyle: TextStyle(color: textColor),
          padding: EdgeInsets.all(padding ?? 0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0)),
        ),
        child: Text(text),
      ),
    );
  }
}
