import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/Provider/selected_order_provider.dart';
import 'package:sample_application/src/core/globalServices/authentication/user_repository.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/helper_widgets/snackbar.dart';

import '../../../../Home/models/order/order.dart';
import '../../../../Home/models/user/address.dart';
import '../../../../Home/order_tracker/step2/step2.dart';

class AddAdressStepTwo extends StatelessWidget {
  AddAdressStepTwo({super.key});
  SelectedOrderState? selectedOrder;
  // final Widget routeInfo;
  final _formKey = GlobalKey<FormState>();
  var Controller = Get.put(UserRepository());
  GlobalService globalservice = GlobalService();
  Address addressObj = Address();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController FullAdress = TextEditingController();
  TextEditingController PinCode = TextEditingController();
  TextEditingController HouseNumber = TextEditingController();
  TextEditingController FloorNumber = TextEditingController();
  Widget TextFormFieldMethod(
      BuildContext context, controllerDetails, label, iconDetails) {
    return TextFormField(
      controller: controllerDetails,
      obscureText: false,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // prefixIcon: Icon(
        //   iconDetails,
        //   color: Theme.of(context).colorScheme.primary,
        // ),
      ),
    );
  }

  validatePincode(pincode) async {
    var boolValue = await UserCurrentLocation.instance
        .validateUserEnteredAddressPincode(pincode);
    return boolValue;
  }

  void saveAdress(context) async {
    if (_formKey.currentState!.validate()) {
      if (await validatePincode(PinCode.text.trim())) {
        addressObj.firstName = firstName.text.trim();
        if (lastName.text.isNotEmpty) {
          addressObj.lastName = lastName.text.trim();
        }
        addressObj.phoneNumber = phoneNumber.text.trim();

        addressObj.fullAddress = FullAdress.text.trim();
        addressObj.pincode = PinCode.text.trim();
        if (HouseNumber.text.isNotEmpty) {
          addressObj.houseNumber = HouseNumber.text.trim();
        }
        if (FloorNumber.text.isNotEmpty) {
          addressObj.floorNumber = FloorNumber.text.trim();
        }

        UserRepository.instance.updateAdress(addressObj);

        Order order = selectedOrder!.getOrder;
        order.address = addressObj;
        selectedOrder!.setOrder = order;
        //UserRepository.instance.getAdress();
        Navigator.pop(context);
        globalservice.navigate(context, StepTwoToBookTest());
      } else {
        CustomSnackbar.showSnackbar(
            'The selected picode is not under serviceable area');
        // Get.snackbar(
        //     "Error", "The selected picode is not under serviceable area");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedOrder = Provider.of<SelectedOrderState>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                        child: Icon(Icons.keyboard_double_arrow_down),
                        onTap: () {
                          Navigator.pop(context);
                          //globalservice.navigate(context, routeInfo);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Enter Complete Address",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Servicable Cities *",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: 100,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Color.fromARGB(255, 81, 81, 81).withOpacity(
                                  0.5), // Set the overlay color and opacity
                              BlendMode.srcATop,
                            ),
                            child: Image.network(
                                width: 100,
                                fit: BoxFit.fill,
                                "https://www.trawell.in/admin/images/upload/793916327vidhansoudha_Main.jpg"),
                          ),
                        ),
                        Positioned(
                            bottom: 1,
                            left: 20,
                            child: Text(
                              "Bengaluru",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ))
                      ]),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: 100,
                      child: Stack(children: [
                        Positioned(
                            bottom: 15,
                            left: 20,
                            child: Text(
                              "Arriving..",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                            ))
                      ]),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: 100,
                      child: Stack(children: [
                        Positioned(
                            bottom: 15,
                            left: 20,
                            child: Text(
                              "Arriving..",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                            ))
                      ]),
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: firstName,
                              obscureText: false,
                              //keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5),
                                labelText: "First Name *",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: Theme.of(context).colorScheme.primary,
                                // ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return 'Please enter a First name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: lastName,
                              obscureText: false,
                              //keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5),
                                labelText: "Last Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // prefixIcon: Icon(
                                //   Icons.home,
                                //   color: Theme.of(context).colorScheme.primary,
                                // ),
                              ),
                              // validator: (value) {
                              //   if (value!.isEmpty || value == null) {
                              //     return 'Please enter an address';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: phoneNumber,
                              obscureText: false,
                              //keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5),
                                labelText: "Phone Number *",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: Theme.of(context).colorScheme.primary,
                                // ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return 'Please enter a Phone Number';
                                }

                                if (value.length != 10) {
                                  return 'Invalid Mobile Number';
                                }
                                if (!value.isNumericOnly) {
                                  return 'Mobile Number must be digits';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: PinCode,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5),
                                labelText: "Pincode *",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // prefixIcon: Icon(
                                //   Icons.post_add,
                                //   color: Theme.of(context).colorScheme.primary,
                                // ),
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: FullAdress,
                        obscureText: false,
                        //keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 5),
                          labelText: "Full Address (Street,Area)*",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // prefixIcon: Icon(
                          //   Icons.home,
                          //   color: Theme.of(context).colorScheme.primary,
                          // ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter an address';
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
                              "House Number *", Icons.post_add),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextFormFieldMethod(context, FloorNumber,
                              "Floor Number *", Icons.post_add),
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
