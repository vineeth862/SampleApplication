import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:sample_application/src/screens/Anthetication/forgot_password_mail.dart";
import "package:sample_application/src/screens/Anthetication/forgot_password_mobile.dart";
import "package:sample_application/src/screens/Anthetication/signup.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  void _saveItem() {
    _formKey.currentState!.validate();
  }

  bool isPasswordVisible = false;
  void onSelectSignup(BuildContext context) {
    //Navigator.of(context).push(route)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SignupPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "./assets/images/Lab_two_people.jpg",
              width: double.infinity,
              alignment: Alignment.centerLeft,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
              child: Text('Welcome Back,',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 30, color: Colors.black)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 0),
              child: Text('Explore the world of diagnostics.',
                  style: Theme.of(context).textTheme.titleLarge!),
            ),
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
                      controller: EmailController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name field cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: PasswordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            context: context,
                            builder: (context) => Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                        "Select one of the option given below to reset your password,",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Get.to(() => ForgotPasswordMail());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mail_outline_rounded,
                                            size: 60,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("E-Mail",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              Text(
                                                  "Reset via Mail Verification",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Get.to(() => ForgotPasswordMobile());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.phone_android_rounded,
                                            size: 60,
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Mobile No",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              Text("Reset via otp Verification",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    ElevatedButton(
                      onPressed: () {
                        // Perform signup logic if form is valid
                      },
                      child: Text('Login', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set the border radius value
                        ),
                        primary: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(horizontal: 100.0),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            onSelectSignup(context);
                          },
                          child: Text(
                            'Signup',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
