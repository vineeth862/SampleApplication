import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/address_operation.dart';
import 'package:sample_application/src/core/helper_widgets/location_unavailable_card.dart';

import '../../../../Home/home.dart';

class InitialAdress extends StatefulWidget {
  const InitialAdress({super.key});

  @override
  State<InitialAdress> createState() => _InitialAdressState();
}

class _InitialAdressState extends State<InitialAdress> {
  GlobalService globalservice = GlobalService();
  //TextEditingController? _nameController;
  final myController = Get.find<UserCurrentLocation>();
  final _pincodeController = TextEditingController();
  bool isWidgetVisible = false;
  @override
  void dispose() {
    _pincodeController!.dispose();

    super.dispose();
  }

  void saveAdress(context) {
    if (_formKey.currentState!.validate()) {}
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.keyboard_double_arrow_down_rounded),
                        onTap: () {
                          globalservice.navigate(context, HomePage());
                        },
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Choose Your Location",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //Navigator.pop(context);
                          globalservice.navigate(context, HomePage());
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, bottom: 8, top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _pincodeController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                              //isCollapsed: true,
                              helperText: ' ',
                              labelText: 'Enter Pincode',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
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
                      Container(
                          height: 68,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    myController.updateGlobalString(
                                        _pincodeController!.text.toString());
                                    // globalservice.showLoader();
                                    // Future.delayed(Duration(seconds: 2), () {});
                                    // globalservice.hideLoader();
                                    globalservice.showLoader();
                                    Future.delayed(Duration(seconds: 2), () {
                                      //globalservice.hideLoader();
                                      Get.back();
                                      myController.pinCodeExists.value
                                          ? globalservice.navigate(
                                              context, HomePage())
                                          : setState(() {
                                              isWidgetVisible = true;
                                            });
                                      // Get.offAll(() => HomePage());
                                    });

                                    //LocationNotAvailable();
                                  }
                                },
                                child: Text("Check"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.tertiary),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Remove circular radius
                                    ),
                                  ),
                                )),
                          )),
                    ],
                  ),
                ),
                Visibility(
                  visible: !isWidgetVisible,
                  child: addressOperation(
                    routeDetails: InitialAdress(),
                  ),
                ),
                Visibility(
                  visible: isWidgetVisible,
                  child: LocationNotAvailable(),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
