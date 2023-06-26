import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/otp_controller.dart';
import 'package:sample_application/src/screens/Anthetication/authentication_repositry.dart';
import 'package:sample_application/src/screens/Anthetication/login.dart';

class HomeSignup extends StatefulWidget {
  const HomeSignup({super.key});

  @override
  State<HomeSignup> createState() => _HomeSignupState();
}

class _HomeSignupState extends State<HomeSignup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController MobileNumberController = TextEditingController();
  var _enteredMobileNumber = '';
  var otp;
  void _saveItem() {
    _enteredMobileNumber = MobileNumberController.text.trim();
    AuthenticationRepository.instance.PhoneNumberAuth(_enteredMobileNumber);
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
                        onPressed: () {
                          Navigator.pop(context);
                          Get.to(() => const LoginScreen());
                        },
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
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                key: _formKey,
                controller: MobileNumberController,
                obscureText: false,
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mobile No.',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _saveItem();
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
                          "Please enter the OTP sent at support888@gmail.com",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 20),
                        OtpTextField(
                          numberOfFields: 6,
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          keyboardType: TextInputType.number,
                          onSubmit: (code) {
                            otp = code;
                            otpController.instance.verifyOtpController(otp);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
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
