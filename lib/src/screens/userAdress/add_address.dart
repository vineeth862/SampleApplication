import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/models/address.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:get/get.dart';

class AddAdress extends StatelessWidget {
  AddAdress({super.key});
  final _formKey = GlobalKey<FormState>();
  var Controller = Get.put(UserRepository());
  address addressObj = address();
  TextEditingController FullAdress = TextEditingController();
  TextEditingController PinCode = TextEditingController();
  TextEditingController HouseNumber = TextEditingController();
  TextEditingController FloorNumber = TextEditingController();

  void saveAdress() {
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
                        Navigator.pop(context);
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
                    Column(
                      children: [
                        TextFormFieldMethod(context, FullAdress,
                            "Enter Full Address *", Icons.home),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        TextFormFieldMethod(
                            context, PinCode, "Pincode *", Icons.post_add),
                      ],
                    ),
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
                        saveAdress();

                        Navigator.pop(context);
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
