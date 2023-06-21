import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import "dart:convert";

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

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(AuthenticationRepository());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
          Theme.of(context).colorScheme.onPrimary.withOpacity(0.9)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Let's get started",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
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
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: EmailController,
                  obscureText: false,
                  decoration: InputDecoration(
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
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  onChanged: (_) => validatePasswords(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    errorText: passwordMatch ? null : 'Passwords do not match',
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
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    // Navigate to login page
                  },
                  child: Text(
                    'Already have an account? Log in',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
