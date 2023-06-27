import 'package:get/get.dart';
import 'package:sample_application/src/authentication/authentication_repository.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/utils/constants/textconstant.dart';

class otpController extends GetxController {
  static otpController get instance => Get.find();

  void verifyOtpController(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(HomePage(title: appTitle)) : Get.back();
  }
}
