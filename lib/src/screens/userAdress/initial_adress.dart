import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/screens/Home/home.dart';
import 'package:sample_application/src/screens/userAdress/address_operation.dart';
import 'package:sample_application/src/screens/userAdress/testing_location_picker.dart';
import 'package:sample_application/src/utils/Provider/loading_provider.dart';

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
    final loadingProvider = Provider.of<LoadingProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _pincodeController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            //isCollapsed: true,
                            helperText: ' ',
                            labelText: 'Enter Pincode',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
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
                    Container(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  myController.updateGlobalString(
                                      _pincodeController!.text.toString());
                                  loadingProvider.startLoading();
                                  Future.delayed(Duration(seconds: 1), () {
                                    loadingProvider.stopLoading();
                                    globalservice.navigate(context, HomePage());
                                    // Get.offAll(() => HomePage());
                                  });
                                }
                              },
                              child: Text("Check"),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius
                                        .zero, // Remove circular radius
                                  ),
                                ),
                              )),
                        ))
                  ],
                ),
              ),

              // Expanded(
              //     child: ElevatedButton(
              //         onPressed: () {}, child: Text("Check")))

              // InkWell(
              //   onTap: () {
              //     globalservice.navigate(
              //         context, getCurrentLocation(title: "Vineeth"));
              //   },
              //   child: Container(
              //     alignment: Alignment.bottomLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.gps_fixed,
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //               child: Text(
              //             "Enter Pincode",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyLarge!
              //                 .copyWith(
              //                     color: Theme.of(context).colorScheme.primary),
              //           )),
              //           Icon(
              //             Icons.arrow_forward_ios_rounded,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              addressOperation(
                routeDetails: InitialAdress(),
              )
              // InkWell(
              //   onTap: () {
              //     globalservice.navigate(context, AddAdress());
              //   },
              //   child: Container(
              //     alignment: Alignment.bottomLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.add,
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //               child: Text(
              //             "Add Address",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyLarge!
              //                 .copyWith(
              //                     color: Theme.of(context).colorScheme.primary),
              //           )),
              //           Icon(
              //             Icons.arrow_forward_ios_rounded,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Divider(
              //   height: 5,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //     child: Text(
              //       "Saved addresses",
              //       style: Theme.of(context)
              //           .textTheme
              //           .titleLarge!
              //           .copyWith(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // isItemsNotPresent
              //     ? Column(
              //         children: [
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Text(
              //             "No Saved Address",
              //             style: Theme.of(context).textTheme.titleLarge,
              //           ),
              //           Divider(
              //             height: 20,
              //           )
              //         ],
              //       )
              //     : SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.6,
              //         width: MediaQuery.of(context).size.width * 0.9,
              //         child: ListView.builder(
              //           itemCount: visibleItemCount +
              //               1, // Add 1 for the "Load More" button
              //           itemBuilder: (context, index) {
              //             if (index < visibleItemCount) {
              //               return InkWell(
              //                 onTap: () {},
              //                 child: Container(
              //                   child: Column(
              //                     children: [
              //                       Row(
              //                         children: [
              //                           SizedBox(width: 10),
              //                           Icon(
              //                             Icons.home,
              //                             color: Theme.of(context)
              //                                 .colorScheme
              //                                 .primary,
              //                           ),
              //                           SizedBox(
              //                             width: 10,
              //                           ),
              //                           Expanded(
              //                             child: ListTile(
              //                               title: Text(items[index]),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       Divider(
              //                         height: 10,
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             } else {
              //               return isButtonEnabled
              //                   ? ElevatedButton(
              //                       onPressed: _loadMoreItems,
              //                       child: Text('Load More'),
              //                     )
              //                   : null;
              //             }
              //           },
              //         ),
              //       )
            ],
          ),
        ),
      ),
    );
  }
}
