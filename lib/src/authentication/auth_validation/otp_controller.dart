import 'package:get/get.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/utils/constants/textconstant.dart';
import '../models/user.dart';
import '../user_repository.dart';

class otpController extends GetxController {
  static otpController get instance => Get.find();
  UserRepository userRepository = UserRepository();
  void verifyOtpController(String otp, Users user) async {
    userRepository.createUser(user);
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    if (isVerified) {
      Get.offAll(HomePage(title: appTitle));
      userRepository.createUser(user);
    } else {
      Get.back();
    }
  }
}
