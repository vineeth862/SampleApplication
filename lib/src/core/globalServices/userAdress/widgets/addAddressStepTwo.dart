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
  TextEditingController flatBuildingNumber = TextEditingController();
  TextEditingController PinCode = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  Widget TextFormFieldMethod(
      BuildContext context, controllerDetails, label, iconDetails) {
    return TextFormField(
      controller: controllerDetails,
      obscureText: false,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5),
        labelText: label,
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        String fulladdress = "";
        addressObj.firstName = firstName.text.trim();
        if (lastName.text.isNotEmpty) {
          addressObj.lastName = lastName.text.trim();
        }
        addressObj.phoneNumber = phoneNumber.text.trim();

        //addressObj.fullAddress = FullAdress.text.trim();

        if (flatBuildingNumber.text.isNotEmpty) {
          addressObj.houseNumber = flatBuildingNumber.text.trim();
          fulladdress += flatBuildingNumber.text.trim() + ",";
        }
        if (street.text.isNotEmpty) {
          addressObj.street = street.text.trim();
          fulladdress += street.text.trim() + ",";
        }

        if (landmark.text.isNotEmpty) {
          addressObj.landmark = landmark.text.trim();
          fulladdress += street.text.trim() + ",";
        }
        addressObj.pincode = PinCode.text.trim();
        fulladdress += PinCode.text.trim() + ",";

        addressObj.city = city.text.trim();
        fulladdress += city.text.trim();
        addressObj.fullAddress = fulladdress;
        UserRepository.instance.updateAdress(addressObj);

        Order order = selectedOrder!.getOrder;
        order.address = addressObj;
        selectedOrder!.setOrder = order;
        //UserRepository.instance.getAdress();
        //Navigator.pop(context);
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
      child: WillPopScope(
        onWillPop: () async {
          Get.off(StepTwoToBookTest());
          return await true;
        },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: InkWell(
                onTap: () {
                  //Navigator.pop(context);
                  globalservice.navigate(context, StepTwoToBookTest());
                },
                child: Icon(
                  Icons.keyboard_double_arrow_down,
                  color: Colors.black,
                ),
              ),
              title: Text("Enter Complete Address",
                  style:
                      Theme.of(context).textTheme.headlineMedium!.copyWith())),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Container(
                //     color: Theme.of(context).colorScheme.secondary,
                //     child: Row(
                //       children: [
                //         InkWell(
                //             child: Icon(Icons.keyboard_double_arrow_down),
                //             onTap: () {
                //               Navigator.pop(context);
                //               //globalservice.navigate(context, routeInfo);
                //             }),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Expanded(
                //           child: Text(
                //             "Enter Complete Address",
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .headlineMedium!
                //                 .copyWith(),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0),
                //   child: Text(
                //     "Servicable Cities *",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headlineSmall!
                //         .copyWith(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0),
                //   child: Row(
                //     children: [
                //       Container(
                //         decoration: BoxDecoration(
                //           border: Border.all(),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         height: 50,
                //         width: 100,
                //         child: Stack(children: [
                //           ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: ColorFiltered(
                //               colorFilter: ColorFilter.mode(
                //                 Color.fromARGB(255, 81, 81, 81).withOpacity(
                //                     0.5), // Set the overlay color and opacity
                //                 BlendMode.srcATop,
                //               ),
                //               child: Image.network(
                //                   width: 100,
                //                   fit: BoxFit.fill,
                //                   "https://www.trawell.in/admin/images/upload/793916327vidhansoudha_Main.jpg"),
                //             ),
                //           ),
                //           Positioned(
                //               bottom: 1,
                //               left: 20,
                //               child: Text(
                //                 "Bengaluru",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headlineSmall!
                //                     .copyWith(color: Colors.white),
                //               ))
                //         ]),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //           color: Color.fromARGB(255, 240, 240, 240),
                //           border: Border.all(),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         height: 50,
                //         width: 100,
                //         child: Stack(children: [
                //           Positioned(
                //               bottom: 15,
                //               left: 20,
                //               child: Text(
                //                 "Arriving..",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headlineSmall!
                //                     .copyWith(
                //                         color:
                //                             const Color.fromARGB(255, 0, 0, 0)),
                //               ))
                //         ]),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //           color: Color.fromARGB(255, 240, 240, 240),
                //           border: Border.all(),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         height: 50,
                //         width: 100,
                //         child: Stack(children: [
                //           Positioned(
                //               bottom: 15,
                //               left: 20,
                //               child: Text(
                //                 "Arriving..",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headlineSmall!
                //                     .copyWith(
                //                         color:
                //                             const Color.fromARGB(255, 0, 0, 0)),
                //               ))
                //         ]),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 8),
                  child: Text(
                    "Contact Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(10)),
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
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(10)),
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
                            Text("+91"),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: phoneNumber,
                                obscureText: false,
                                //keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 5),
                                  labelText: "Phone Number *",
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(10)),
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
                            // Expanded(
                            //   child: TextFormField(
                            //     controller: PinCode,
                            //     obscureText: false,
                            //     keyboardType: TextInputType.number,
                            //     decoration: InputDecoration(
                            //       contentPadding: EdgeInsets.symmetric(
                            //           vertical: 1.0, horizontal: 5),
                            //       labelText: "Pincode *",
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10)),
                            //       // prefixIcon: Icon(
                            //       //   Icons.post_add,
                            //       //   color: Theme.of(context).colorScheme.primary,
                            //       // ),
                            //     ),
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         return 'Please enter a pincode';
                            //       }
                            //       if (value.length != 6) {
                            //         return 'Pincode must be 6 digits';
                            //       }
                            //       if (!value.isNumericOnly) {
                            //         return 'Pincode must be digits';
                            //       }

                            //       return null;
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Address Details",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: flatBuildingNumber,
                          obscureText: false,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 5),
                            labelText: "House/Flat Number/Building*",
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10)),
                            // prefixIcon: Icon(
                            //   Icons.home,
                            //   color: Theme.of(context).colorScheme.primary,
                            // ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return 'Please enter House/Flat Number/Building';
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

                        TextFormFieldMethod(context, street,
                            "Street/Locality *", Icons.post_add),

                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            TextFormFieldMethod(
                                context, landmark, "LandMark", Icons.post_add),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  controller: PinCode,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 5),
                                    labelText: "Pincode *",
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(10)),
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
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  controller: city,
                                  obscureText: false,
                                  //keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 5),
                                    labelText: "City *",
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(10)),
                                    // prefixIcon: Icon(
                                    //   Icons.post_add,
                                    //   color: Theme.of(context).colorScheme.primary,
                                    // ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a city name';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Text(
                        //   "Save Address as",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headlineSmall!
                        //       .copyWith(fontWeight: FontWeight.bold),
                        // ),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              saveAdress(context);
                              //globalservice.navigate(context, routeInfo);
                              //Navigator.pop(context);
                            },
                            child: const Text("Add Address"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set the border radius value
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100.0),
                            ),
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
      ),
    );
  }
}
