import 'dart:async';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:pinput/pinput.dart';
import 'package:telephony/telephony.dart';

class otpTestScreen extends StatefulWidget {
  const otpTestScreen({super.key});

  @override
  State<otpTestScreen> createState() => _otpTestScreenState();
}

class _otpTestScreenState extends State<otpTestScreen> {
  String otp = '';
  Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool isResendVisible = false;
  int timerDuration = 120; // 2 minutes in seconds
  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerDuration > 0) {
          timerDuration--;
        } else {
          isResendVisible = true;
          _timer.cancel();
        }
      });
    });
  }

  void resendOTP() {
    // Implement your logic to resend OTP here
    // For example, you can call an API to request a new OTP
    // After requesting, reset the timer and hide the Resend button
    setState(() {
      timerDuration = 120;
      isResendVisible = false;
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  //var Controller = Get.put(otpController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    startTimer();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address);
        print(message.body);

        String sms = message.body.toString();

        if (message.body!
            .contains('experimentdatabase-87de1.firebaseapp.com')) {
          String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
          //otpbox.set(otpcode.split(""));
          pinController.setText(otpcode.toString());
          setState(() {
            // refresh UI
            pinController.setText(otpcode.toString().substring(0, 6));
          });
        } else {
          print("error");
        }
      },
      listenInBackground: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Pinput(
              length: 6,
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
              listenForMultipleSmsOnAndroid: false,
              defaultPinTheme: defaultPinTheme,
              // validator: (value) {
              //   return value == '2222' ? null : 'Pin is incorrect';
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
                otp = pin;
                //otpController.instance.verifyOtpController(otp, widget.user);
              },

              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isResendVisible
                ? ElevatedButton(
                    onPressed: () => resendOTP(),
                    child: Text('Resend OTP'),
                  )
                : Text('Time remaining: ${timerDuration}s'),
          ],
        ),
      ),
    );
  }
}
