import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/order/order.dart';
import 'package:sample_application/src/screens/Home/models/package/package.dart';
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
import '../../package/package-suggetion-list.dart';
import 'confirmation-allert.dart';

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
  final _formKey = GlobalKey<FormState>();
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
    var future = new Future.delayed(const Duration(milliseconds: 1000))
        .then((value) => this.loadUserName(''));
    //this.loadUserName('');
  }

  void loadUserName(name) async {
    if (selectedOrder != null && selectedOrder?.order?.user?.age != null) {
      Order order = selectedOrder?.getOrder;
      String? gender = order.user?.gender;
      String? name = order.user?.userName;
      String? age = order.user?.age;

      if (name != null && name.isNotEmpty) {
        _namecontroller.setText(name);
      }
      if (gender != null && gender.isNotEmpty) {
        setState(() {
          selectedGender = gender;
        });
      }
      if (age != null && age.isNotEmpty) {
        _agecontroller.setText(age);
      }
      if (order.self == true) {
        setState(() {
          isMySelfButtonSelected = true;
          isOthersButtonSelected = false;
        });
      }
      if (order.self == false) {
        setState(() {
          isOthersButtonSelected = true;
          isMySelfButtonSelected = false;
        });
      }
    } else {
      if (isMySelfButtonSelected) {
        var user = await Get.put(UserRepository()).getUser();

        String name = user.data()?['userName'];

        if (name != "null" && name.isNotEmpty) {
          _namecontroller.setText(name);
        }
      } else {
        _namecontroller.setText(name);
      }
    }
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    super.dispose();
  }

  Future<bool> UpdateWidget() async {
    // if (_formKey.currentState!.validate()) {
    if (selectedOrder != null) {
      Order order = selectedOrder!.getOrder;
      order.self = isMySelfButtonSelected;
      order.tests = selectedTest!.getSelectedTest;
      order.packages = selectedTest!.getSelectedPackage;
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
    // }
    // else {
    //   return false;
    // }
  }

  Column generateListTileBodyForTest(Test test) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(test.testName), Text(test.price)],
    );
  }

  Column generateListTileBodyForPackage(Package package) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(package.displayName), Text(package.price)],
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
                              // if (selectedOrder != null) {
                              isMySelfButtonSelected = true;
                              isOthersButtonSelected = false;
                              if (selectedOrder != null) {
                                Order order = selectedOrder?.getOrder;
                                order.self = true;
                                order.user?.userName = null;
                                order.user?.age = null;
                                order.user?.gender = '';
                              }
                              _agecontroller.text = '';
                              selectedGender = '';
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
                              if (selectedOrder != null) {
                                Order order = selectedOrder?.getOrder;
                                order.self = false;
                                order.user?.userName = null;
                                order.user?.age = null;
                                order.user?.gender = '';
                              }
                              isMySelfButtonSelected = false;
                              isOthersButtonSelected = true;
                              _agecontroller.text = '';
                              selectedGender = '';
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
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  }, // Other properties and validation for the age field
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
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'^([1-9]|[1-9][0-9]|1[01][0-9]|120)$')),
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
                          ),
                        ],
                      )),

                  // Add more form components or rows as needed
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              'Added Tests/Packages',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          SizedBox(
            height: 500,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...selectedTest!.getSelectedTest
                        .map(
                          (test) => ListTile(
                            title: generateListTileBodyForTest(test),
                            iconColor: Theme.of(context).colorScheme.primary,
                            leading: Icon(Icons.medical_services),
                            trailing: IconButton(
                                onPressed: () {
                                  selectedTest!.removeTest(test);
                                  if ((selectedTest!
                                              .getSelectedPackage.length ==
                                          0 &&
                                      selectedTest!.getSelectedTest.length ==
                                          0)) {
                                    this
                                        .globalservice
                                        .navigate(context, SearchBarPage());
                                  }
                                },
                                icon: Icon(Icons.delete_outlined)),
                          ),
                        )
                        .toList(),
                    ...selectedTest!.getSelectedPackage
                        .map(
                          (package) => ListTile(
                            title: generateListTileBodyForPackage(package),
                            iconColor: Theme.of(context).colorScheme.primary,
                            leading: Icon(Icons.medical_services),
                            trailing: IconButton(
                                onPressed: () {
                                  selectedTest!.removePackage(package);
                                  if ((selectedTest!
                                              .getSelectedPackage.length ==
                                          0 &&
                                      selectedTest!.getSelectedTest.length ==
                                          0)) {
                                    this.globalservice.navigate(context,
                                        PackageSuggetionList(labCode: ""));
                                  }
                                },
                                icon: Icon(Icons.delete_outlined)),
                          ),
                        )
                        .toList(),
                    ListTile(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: Allert(),
                            ); // Custom widget for the dialog content
                          },
                        );

                        UpdateWidget();
                      },
                      title: Text(
                        "Add more Items",
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
          ),
        ],
      ),
    );
  }
}
