import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:get_storage/get_storage.dart';

class onBoardingController extends GetxController {
  static onBoardingController get instance => Get.find();
  GlobalService globalService = GlobalService();
  final pageController = PageController();
  Rx<int> currentIndex = 0.obs;

  void updatePageIndex(index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value == 2) {
      //globalService.navigate(context, HomePage());

      currentIndex.value = 0;
      final storage = GetStorage();
      storage.write("isFirstTime", false);
      Get.to(Welcomesignin());
    } else {
      int page = currentIndex.value + 1;

      pageController.jumpToPage(page);
    }
  }
}
