import 'package:flutter/material.dart';
import 'package:get/get.dart';

class snackBarWidget extends StatelessWidget {
  final String messageToShow;
  const snackBarWidget({super.key, required this.messageToShow});

  @override
  GetSnackBar build(BuildContext context) {
    return GetSnackBar(
      backgroundColor: Color.fromARGB(255, 203, 57, 24),

      icon: Icon(
        Icons.warning_amber_rounded,
        color: Theme.of(context).colorScheme.secondary,
      ),
      forwardAnimationCurve: Curves.decelerate,
      //margin: EdgeInsets.all(10),
      message: messageToShow,
      maxWidth: 400, // Set the desired width
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM, // Optional: Specify position
    );
  }
}
