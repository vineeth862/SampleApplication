import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:get/get.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import '../../screens/Home/models/user/user.dart';
import '../user_repository.dart';

class otpController extends GetxController {
  static otpController get instance => Get.find();
  UserRepository userRepository = UserRepository();
  GlobalService globalservice = GlobalService();
  void verifyOtpController(String otp, User user) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    if (isVerified) {
      Get.offAll(HomePage());
      var authUser = fb_auth.FirebaseAuth.instance.currentUser;
      if (authUser != null) {
        user.uId = authUser.uid;
        user.created = authUser.metadata.creationTime.toString();
        user.lastSignedIn = authUser.metadata.lastSignInTime.toString();
      }

      userRepository.createUser(user);
    } else {
      Get.snackbar("Error", "Invalid OTP, Enter a Valid OTP");
    }
  }

  void verifyOtpControllerNumberChange(String otp, User user) async {
    String oldUserKey = globalservice.getCurrentUserKey();
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    if (isVerified) {
      Get.offAll(HomePage());

      userRepository.updateUser(user, oldUserKey);
    } else {
      Get.snackbar("Error", "Something went wrong try again");
    }
  }
}
