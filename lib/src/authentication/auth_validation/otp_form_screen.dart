import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sample_application/src/authentication/auth_validation/otp_controller.dart';
import 'package:sample_application/src/screens/Home/models/user/user.dart';
import 'package:telephony/telephony.dart';

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
  //var Controller = Get.put(otpController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address);
        print(message.body);

        String sms = message.body.toString();

        if (message.body!
            .contains('experimentdatabase-87de1.firebaseapp.com')) {
          String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
          otpbox.set(otpcode.split(""));

          setState(() {
            // refresh UI
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
    return SingleChildScrollView(
      child: Column(
        children: [
          OTPTextField(
            outlineBorderRadius: 10,
            controller: otpbox,
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 50,
            style: TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              otp = pin;
              otpController.instance.verifyOtpController(otp, widget.user);
            },
          ),
          SizedBox(
            height: 10,
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
