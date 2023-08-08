import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/utils/constants/textconstant.dart';
import '../models/user.dart';
import '../user_repository.dart';

class otpController extends GetxController {
  static otpController get instance => Get.find();
  UserRepository userRepository = UserRepository();
  GlobalService globalservice = GlobalService();
  void verifyOtpController(String otp, Users user) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    if (isVerified) {
      Get.offAll(HomePage());
      var authUser = FirebaseAuth.instance.currentUser;
      if (authUser != null) {
        user.uId = authUser.uid;
        user.created = authUser.metadata.creationTime.toString();
        user.lastSignedIn = authUser.metadata.lastSignInTime.toString();
      }

      userRepository.createUser(user);
    } else {
      Get.back();
    }
  }

  void verifyOtpControllerNumberChange(String otp, Users user) async {
    String oldUserKey = globalservice.getCurrentUserKey();
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    if (isVerified) {
      Get.offAll(HomePage());
      print(user.mobile);
      userRepository.updateUser(user, oldUserKey);
    } else {
      Get.back();
    }
  }
}
