import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Anthetication/login.dart';
//import 'package:http/http.dart' as http;

//import 'package:get/get.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordMatch = true;
  var _enteredName = '';
  var _email = '';
  var _password = '';
  var _confirmedPassword = '';

  void _saveItem() {
    _formKey.currentState!.validate();
  }
  //     _enteredName = NameController.text;
  //     _email = EmailController.text.trim();
  //     _password = confirmPasswordController.text.trim();
  //     AuthenticationRepository.instance
  //         .createUserWithEmailAndPassword(_email, _password);
  //     http.post(url,
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //         body: json.encode({
  //           "Name": NameController.text,
  //           "Email": EmailController.text,
  //           "password": confirmPasswordController.text,
  //         }));
  //   }
  // }

  void validatePasswords() {
    setState(() {
      passwordMatch = passwordController.text == confirmPasswordController.text;
    });
  }

  void onSelectLogin(BuildContext context) {
    //Navigator.of(context).push(route)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(AuthenticationRepository());

    return Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text('Create an Account',
                  style: Theme.of(context).textTheme.displayLarge!),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    Container(
                      height: 45,
                      child: TextFormField(
                        controller: NameController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'Name',
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
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      height: 45,
                      child: TextFormField(
                        controller: EmailController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          //errorText: emailExists ? 'Email already exists' : null,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return "Email field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      height: 45,
                      child: TextFormField(
                        controller: phoneNoController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Mobile No.',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      height: 45,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      onChanged: (_) => validatePasswords(),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.fingerprint),
                        errorText:
                            passwordMatch ? null : 'Passwords do not match',
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        // Perform signup logic if form is valid

                        if (passwordMatch) {
                          // Perform signup logic
                          _saveItem();
                        }
                      },
                      child: Text('Sign Up', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set the border radius value
                        ),
                        primary: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(horizontal: 100.0),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            onSelectLogin(context);
                          },
                          child: Text(
                            'Login',
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
    );
  }
}
