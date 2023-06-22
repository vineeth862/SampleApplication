import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sample_application/src/screens/signup.dart";

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
                            context: context,
                            builder: (context) => Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [Icon(Icons.email_outlined)],
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
                          width: 45,
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
