import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/otp_controller.dart';
import 'package:telephony/telephony.dart';

import '../../../../Home/models/user/user.dart';
import 'package:pinput/pinput.dart';

class OtpPhoneWidget extends StatefulWidget {
  final User user;
  const OtpPhoneWidget({Key? key, required this.user}) : super(key: key);

  @override
  _OtpPhoneWidgetState createState() => _OtpPhoneWidgetState();
}

class _OtpPhoneWidgetState extends State<OtpPhoneWidget>
    with TickerProviderStateMixin {
  String otp = '';
  Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  //var Controller = Get.put(otpController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // OTPTextField(
          //   outlineBorderRadius: 10,
          //   spaceBetween: 20,
          //   otpFieldStyle: OtpFieldStyle(),
          //   //contentPadding: EdgeInsets.only(left: 10),
          //   controller: otpbox,
          //   length: 6,
          //   width: MediaQuery.of(context).size.width,
          //   fieldWidth: 40,
          //   style: TextStyle(fontSize: 17),
          //   textFieldAlignment: MainAxisAlignment.center,
          //   fieldStyle: FieldStyle.underline,
          //   obscureText: false,

          //   onCompleted: (pin) {
          //     otp = pin;
          //     otpController.instance.verifyOtpController(otp, widget.user);
          //   },
          //   onChanged: (pin) {},
          // ),
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
              otpController.instance.verifyOtpController(otp, widget.user);
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
          ElevatedButton(
              onPressed: () {
                otpController.instance.verifyOtpController(otp, widget.user);
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
