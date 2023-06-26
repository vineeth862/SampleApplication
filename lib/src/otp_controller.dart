import 'package:get/get.dart';
import 'package:sample_application/src/screens/Anthetication/authentication_repositry.dart';
import 'package:sample_application/src/screens/Anthetication/login.dart';

class otpController extends GetxController {
  static otpController get instance => Get.find();

  void verifyOtpController(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const LoginScreen()) : Get.back();
  }
}
