import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sample_application/src/core/globalServices/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/core/globalServices/checkOnlineConnectivity.dart';
import 'package:sample_application/src/core/globalServices/authentication/onboarding/onboarding.dart';

import '../../../../Home/home.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;
  TextEditingController pinController = TextEditingController();
  final deviceStorage = GetStorage();
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    //firebaseUser.bindStream(_auth.userChanges());
    //ever(firebaseUser, _setInitialScreen);
    Future.delayed(Duration(seconds: 2), () {
      //globalservice.showLoader();
      //Get.offAll(() => HomePage());

      //globalservice.hideLoader();
      // FlutterNativeSplash.remove();
      Get.offAll(() => ConnectivityChecker());
      //screenRedirect();
      //_setInitialScreen(firebaseUser.value);
    });
  }

  screenRedirect() async {
    deviceStorage.writeIfNull("isFirstTime", true);
    deviceStorage.read("isFirstTime") != true
        ? _setInitialScreen(firebaseUser.value)
        : Get.offAll(() => onBoardingScreen());
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const Welcomesignin())
        : Get.offAll(() => HomePage());
  }

  Future<void> PhoneNumberAuth(
    String MobileNumber,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: MobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: ((verificationId, resendToken) {
        this.verificationId.value = verificationId;
        // print(verificationId.toString());
        // pinController.setText(verificationId.toString());
      }),
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == "invalid-phone-number") {
          Get.snackbar("Error", "Phone Number is not valid");
        } else {
          Get.snackbar("Error", "Something went wrong try again");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp));
      return credentials.user != null ? true : false;
    } catch (e) {
      return false;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => Welcomesignin());
  }
}
