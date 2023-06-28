import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:countries_flag/countries_flag.dart';
import 'package:pinput/pinput.dart';
import 'package:sample_application/src/authentication/authentication_repository.dart';
import 'package:sample_application/src/authentication/otp_controller.dart';
import 'package:sample_application/src/authentication/pin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
//import 'package:sample_application/src/otp_controller.dart';
//import 'package:sample_application/src/screens/Anthetication/authentication_repositry.dart';

class Welcomesignin extends StatefulWidget {
  const Welcomesignin({super.key});

  @override
  State<Welcomesignin> createState() => _WelcomesigninState();
}

class _WelcomesigninState extends State<Welcomesignin> {
  final _formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  TextEditingController MobileNumberController = TextEditingController();
  GlobalService globalservice = GlobalService();
  var _enteredMobileNumber = '';
  var otp;
  var Controller = Get.put(otpController());
  void _validate() {
    _formKey.currentState!.validate();
  }

  void _saveItem() {
    _enteredMobileNumber = MobileNumberController.text.trim();
    _enteredMobileNumber = "+91" + _enteredMobileNumber.toString();
    AuthenticationRepository.instance.PhoneNumberAuth(_enteredMobileNumber);
    print(_enteredMobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Image.asset(
                  "./assets/images/Lab_two_people.jpg",
                  width: double.infinity,
                  height: 250,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: Text(
                'Explore the world of diagnostics.',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text('Log in or sign up',
                  style: Theme.of(context).textTheme.titleLarge!),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountriesFlag(
                        Flags.india,
                        width: 30,
                        height: 25,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      key: _formKey,
                      controller: MobileNumberController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Mobile No.',
                        prefixText: '+91 ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _saveItem();

                //globalservice.navigate(context, const PinputExample());
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "OTP",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please enter the OTP sent to registered phone number",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          child: Pinput(
                            length: 6,
                            focusNode: focusNode,
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            //listenForMultipleSmsOnAndroid: true,
                            //filled: true,
                            //fillColor: Colors.black.withOpacity(0.1),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              otp = value;
                              otpController.instance.verifyOtpController(otp);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _validate();
                            otpController.instance.verifyOtpController(otp);
                          },
                          child: Text("Submit"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius value
                            ),
                            primary: Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text('Continue', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Set the border radius value
                ),
                primary: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 100.0),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
