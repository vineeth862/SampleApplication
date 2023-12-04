import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Get.currentRoute != '/LoaderScreen';
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(
              255, 255, 255, 255), // Set background color to transparent
          body: Center(
            child: Container(
              width: 100,
              // Make container background transparent
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [Colors.red.shade400], // Set loader color to white
                strokeWidth: 10, // Adjust the strokeWidth as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
