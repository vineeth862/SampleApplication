import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ForgotPasswordMobile extends StatelessWidget {
  ForgotPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController phoneNoController = TextEditingController();
    void _saveItem() {
      _formKey.currentState!.validate();
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 105.0, vertical: 30),
                child: Image.asset(
                  "./assets/images/rotation.png",
                  width: 200,
                  alignment: Alignment.center,
                ),
              ),
              Text("Forgot Password?",
                  style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 10),
              Text("Please enter Mobile Number to reset you password",
                  style: Theme.of(context).textTheme.bodyLarge),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: phoneNoController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone_android_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name field cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Perform signup logic if form is valid
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Please enter the OTP sent at support888@gmail.com",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 20),
                                  OtpTextField(
                                    numberOfFields: 4,
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.1),
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Submit"),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Set the border radius value
                                      ),
                                      primary:
                                          Theme.of(context).colorScheme.primary,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 100.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text('Get OTP', style: TextStyle(fontSize: 20)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
