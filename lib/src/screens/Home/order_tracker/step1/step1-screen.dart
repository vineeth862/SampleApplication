import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../utils/Provider/selected_test_provider.dart';
import '../../../../utils/helper_widgets/custom-button.dart';

class StepOneScreen extends StatefulWidget {
  @override
  _StepOneScreenState createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  bool checkboxValue = false;
  String selectedGender = '';
  bool isMySelfButtonSelected = true;
  bool isOthersButtonSelected = false;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.loadUserName("Pramod CR");
  }

  void loadUserName(name) {
    _namecontroller.setText(name);
    print(selectedGender);
    print(_agecontroller.text);
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTest = Provider.of<SelectedTestState>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              'Who is getting tested?',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          isElevated: isMySelfButtonSelected,
                          text: "My Self",
                          onPressed: () {
                            setState(() {
                              this.loadUserName("Pramod CR");
                              isMySelfButtonSelected = true;
                              isOthersButtonSelected = false;
                            });
                          },
                          primaryColor: Theme.of(context).colorScheme.primary,
                          padding: 0.0,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomButton(
                          isElevated: isOthersButtonSelected,
                          text: "Others",
                          onPressed: () {
                            setState(() {
                              this.loadUserName("");
                              isMySelfButtonSelected = false;
                              isOthersButtonSelected = true;
                            });
                          },
                          primaryColor: Theme.of(context).colorScheme.primary,
                          padding: 0.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            enabled: !isMySelfButtonSelected,
                            labelText: 'Full name*',
                            border: OutlineInputBorder(),
                          ),
                          // Other properties and validation for the age field
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: _agecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^([1-9]|[1-9][0-9]|1[01][0-9]|120)$')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            int? age = int.tryParse(value);
                            if (age == null || age <= 0 || age >= 150) {
                              return 'Please enter a valid age';
                            }
                            return null; // Return null to indicate no error
                          },
                        ),
                      ),
                      Radio(
                        value: 'Male',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: 'Female',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                      ),
                      Text('Female'),
                    ],
                  )
                  // Add more form components or rows as needed
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              'Tests Are Added  / Add more Test',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("Selected Test"), Text("135")],
                    ),
                    iconColor: Theme.of(context).colorScheme.primary,
                    leading: Icon(Icons.medical_services),
                    trailing: IconButton(
                        onPressed: () {
                          selectedTest.removeTest("03");
                        },
                        icon: Icon(Icons.delete_outlined)),
                  ),
                  ListTile(
                    title: Text(
                      "Add more test",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    iconColor: Theme.of(context).colorScheme.primary,
                    leading: Icon(Icons.add_circle_outline),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
