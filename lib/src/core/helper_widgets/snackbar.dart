import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar(messageToShow, {bool? failureOrSuccess}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Color.fromARGB(255, 203, 57, 24),

        icon: Icon(
          Icons.warning_amber_rounded,
        ),
        forwardAnimationCurve: Curves.decelerate,
        //margin: EdgeInsets.all(10),
        message: messageToShow,
        maxWidth: 400, // Set the desired width
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM, // Optional: Specify position
      ),
    );
  }
}
