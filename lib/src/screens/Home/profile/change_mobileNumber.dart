import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries_flag/countries_flag.dart';
import 'package:pinput/pinput.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/authentication/auth_validation/otp_controller.dart';
import 'package:sample_application/src/authentication/models/user.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:sample_application/src/global_service/global_service.dart';

class changeMobileNumber extends StatefulWidget {
  const changeMobileNumber({super.key});

  @override
  State<changeMobileNumber> createState() => _changeMobileNumberState();
}

class _changeMobileNumberState extends State<changeMobileNumber> {
  final focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  GlobalService globalservice = GlobalService();
  UserRepository userRepository = UserRepository();
  var Controller = Get.put(otpController());
  Users user = Users();
  var otp;
  void _validate() {
    _formKey.currentState!.validate();
  }

  void _saveItem() {
    user.mobile = "+91" + mobileNumberController.text.trim();

    AuthenticationRepository.instance.PhoneNumberAuth(user.mobile!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  child: Text('Enter New Number',
                      style: Theme.of(context).textTheme.displayLarge!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            key: _formKey,
                            controller: mobileNumberController,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile No.',
                              prefixText: '+91 ',

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              //prefixIcon: const Icon(Icons.phone),
                            ),
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "OTP",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(
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
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  otp = value;
                                  otpController.instance
                                      .verifyOtpControllerNumberChange(
                                          otp, user);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _validate();

                                otpController.instance
                                    .verifyOtpControllerNumberChange(otp, user);
                              },
                              child: const Text("Submit"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set the border radius value
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Continue', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius value
                    ),
                    primary: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
