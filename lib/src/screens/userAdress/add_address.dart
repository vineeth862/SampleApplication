import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/models/user/address.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/global_service/global_service.dart';

class AddAdress extends StatelessWidget {
  AddAdress({super.key, required this.routeInfo});

  final Widget routeInfo;
  final _formKey = GlobalKey<FormState>();
  var Controller = Get.put(UserRepository());
  GlobalService globalservice = GlobalService();
  address addressObj = address();

  TextEditingController FullAdress = TextEditingController();
  TextEditingController PinCode = TextEditingController();
  TextEditingController HouseNumber = TextEditingController();
  TextEditingController FloorNumber = TextEditingController();

  void saveAdress(context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      addressObj.fullAddress = FullAdress.text.trim();
      addressObj.pincode = PinCode.text.trim();
      if (HouseNumber.text.isNotEmpty) {
        addressObj.houseNumber = HouseNumber.text.trim();
      }
      if (FloorNumber.text.isNotEmpty) {
        addressObj.floorNumber = FloorNumber.text.trim();
      }

      UserRepository.instance.updateAdress(addressObj);
      UserRepository.instance.getAdress();
      globalservice.navigate(context, routeInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  InkWell(
                      child: Icon(Icons.keyboard_double_arrow_down),
                      onTap: () {
                        //Navigator.pop(context);
                        globalservice.navigate(context, routeInfo);
                      }),
                  SizedBox(
                    width: 45,
                  ),
                  Expanded(
                    child: Text(
                      "Enter Complete Address",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: FullAdress,
                      obscureText: false,
                      //keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Full Address *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.home,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: PinCode,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Pincode *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.post_add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a pincode';
                        }
                        if (value.length != 6) {
                          return 'Pincode must be 6 digits';
                        }
                        if (!value.isNumericOnly) {
                          return 'Pincode must be digits';
                        }
                        return null;
                      },
                    ),
                    // Column(
                    //   children: [
                    //     TextFormFieldMethod(
                    //         context, PinCode, "Pincode *", Icons.post_add),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        TextFormFieldMethod(context, HouseNumber,
                            "House Number (Optional)", Icons.post_add),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        TextFormFieldMethod(context, FloorNumber,
                            "Floor Number (Optional)", Icons.post_add),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveAdress(context);
                        //globalservice.navigate(context, routeInfo);
                        //Navigator.pop(context);
                      },
                      child: const Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set the border radius value
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
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

  Widget TextFormFieldMethod(
      BuildContext context, controllerDetails, label, iconDetails) {
    return TextFormField(
      controller: controllerDetails,
      obscureText: false,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: Icon(
          iconDetails,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
