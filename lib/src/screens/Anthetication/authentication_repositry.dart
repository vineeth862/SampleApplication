import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/screens/Anthetication/exceptions/signup_email_password_exception.dart';
import 'package:sample_application/src/screens/Anthetication/signup.dart';
import 'package:sample_application/src/screens/home.dart';
import 'package:sample_application/src/screens/Anthetication/home_signup.dart';
import 'package:sample_application/src/utils/constants/constant.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    print("Hii");
    print(user);
    print(firebaseUser.value);
    user == null
        ? Get.offAll(() => const HomeSignup())
        : Get.offAll(() => const HomePage(
              title: appTitle,
            ));
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => HomePage(
                title: appTitle,
              ))
          : Get.offAll(() => const SignupPage());
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print("Firebase Auth Exception -${ex.message}");
      throw ex;
    } catch (_) {
      const ex = SignupEmailPasswordFailure();
      print("Exception -${ex.message}");
      throw ex;
    }
  }
  // Future<void> createUserWithPhoneNumber(String MobileNumber) async {
  //   try {
  //     await _auth.(
  //         email: email, password: password);
  //     firebaseUser.value != null
  //         ? Get.offAll(() => HomePage(
  //               title: appTitle,
  //             ))
  //         : Get.offAll(() => const SignupPage());
  //   } on FirebaseAuthException catch (e) {
  //     final ex = SignupEmailPasswordFailure.code(e.code);
  //     print("Firebase Auth Exception -${ex.message}");
  //     throw ex;
  //   } catch (_) {
  //     const ex = SignupEmailPasswordFailure();
  //     print("Exception -${ex.message}");
  //     throw ex;
  //   }
  // }

  Future<void> PhoneNumberAuth(String MobileNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: MobileNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: ((verificationId, resendToken) {
        this.verificationId.value = verificationId;
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

  Future<bool> verifyOTP(String OTP) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.value, smsCode: OTP));
    return credentials.user != null ? true : false;
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
