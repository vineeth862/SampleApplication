import 'package:flutter/material.dart';

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
        body: Column(
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
                      },
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
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
    );
  }
}
