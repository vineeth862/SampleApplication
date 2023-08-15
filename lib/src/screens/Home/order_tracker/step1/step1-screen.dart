import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/Home/models/test/test.dart';
import 'package:sample_application/src/screens/Home/models/user/user.dart';
import 'package:sample_application/src/utils/Provider/selected_order_provider.dart';
import '../../../../authentication/user_repository.dart';
import '../../../../global_service/global_service.dart';
import '../../../../utils/Provider/search_provider.dart';
import '../../../../utils/Provider/selected_test_provider.dart';
import '../../../../utils/helper_widgets/custom-button.dart';
import '../../explore/Search/Cards/filter-lab-list.dart';
import '../../explore/Search/search_field.dart';

class StepOneScreen extends StatefulWidget {
  StepOneScreen();
  final screen = _StepOneScreenState();

  @override
  _StepOneScreenState createState() => screen;

  Future<bool> btnClicked() async {
    return await screen.UpdateWidget();
  }
}

class _StepOneScreenState extends State<StepOneScreen> {
  bool checkboxValue = false;
  String selectedGender = '';
  bool isMySelfButtonSelected = true;
  bool isOthersButtonSelected = false;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();
  GlobalService globalservice = GlobalService();
  SearchListState? searchState;
  SelectedOrderState? selectedOrder;
  SelectedTestState? selectedTest;
  Test? filteredTest;
  @override
  void initState() {
    super.initState();

    this.loadUserName('');
  }

  void loadUserName(name) async {
    if (isMySelfButtonSelected) {
      var user = await Get.put(UserRepository()).getUser();

      String name = user.data()?['userName'];
      if (name != null && name.isNotEmpty) {
        _namecontroller.setText(name);
      }
    } else {
      _namecontroller.setText(name);
    }
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    super.dispose();
  }

  Future<bool> UpdateWidget() async {
    if (selectedOrder != null) {
      Order order = selectedOrder!.getOrder;
      order.self = isMySelfButtonSelected;
      order.tests = selectedTest!.getSelectedTest;
      if (isMySelfButtonSelected) {
        var user = await Get.put(UserRepository()).getUser();
        order.user?.gender = selectedGender;
        order.user?.gender = selectedGender;
        order.user = User(
            userName: user.data()?['userName'],
            age: _agecontroller.text,
            gender: selectedGender,
            mobile: user.data()?['mobile']);
      } else {
        order.user = User(
            userName: _namecontroller.text,
            age: _agecontroller.text,
            gender: selectedGender);
      }

      selectedOrder!.setOrder = order;
    }
    return true;
  }

  Column generateListTileBody(Test test) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(test.testname), Text(test.price)],
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedTest = Provider.of<SelectedTestState>(context);
    searchState = Provider.of<SearchListState>(context);
    selectedOrder = Provider.of<SelectedOrderState>(context);
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
                              isMySelfButtonSelected = true;
                              isOthersButtonSelected = false;
                              this.loadUserName("");
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
                              isMySelfButtonSelected = false;
                              isOthersButtonSelected = true;
                              this.loadUserName("");
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
                  ...selectedTest!.getSelectedTest
                      .map(
                        (test) => ListTile(
                          title: generateListTileBody(test),
                          iconColor: Theme.of(context).colorScheme.primary,
                          leading: Icon(Icons.medical_services),
                          trailing: IconButton(
                              onPressed: () {
                                selectedTest!.removeTest(test);
                                if (selectedTest!.getSelectedTest.length == 0) {
                                  this
                                      .globalservice
                                      .navigate(context, SearchBarPage());
                                }
                              },
                              icon: Icon(Icons.delete_outlined)),
                        ),
                      )
                      .toList(),
                  ListTile(
                    onTap: () async {
                      if (selectedTest!.getSelectedTest.length > 0) {
                        var lab = selectedTest!.getSelectedTest[0];
                        await searchState?.cardClicked(lab.labCode, false);
                        this.globalservice.navigate(
                            context,
                            FilteredLabCardlistPage(
                              title: lab.labName,
                              labCode: lab.labCode,
                              location: "location",
                            ));
                      }
                    },
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
