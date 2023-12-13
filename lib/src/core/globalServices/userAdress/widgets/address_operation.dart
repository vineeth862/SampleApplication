import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/core/globalServices/authentication/user_repository.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/addressForm.dart';

import '../../../../Home/home.dart';
import '../../../../Home/models/user/address.dart';

class addressOperation extends StatefulWidget {
  final Widget routeDetails;
  addressOperation({super.key, required this.routeDetails});

  @override
  State<addressOperation> createState() => _addressOperationState();
}

class _addressOperationState extends State<addressOperation> {
  GlobalService globalservice = GlobalService();

  var Controller = Get.put((UserRepository()));
  final myController = Get.find<UserCurrentLocation>();

  //var fetchedAddress = UserRepository.instance.getAdress();

  List<address> concatenatedAddressList = [];
  concatenateAddressList() async {
    List<Map<String, dynamic>> fetchedAddress =
        await UserRepository.instance.getAdress();
    //print(fetchedAddress.toList());
    bool dataPresent = false;
    List<address> fullAddress = [];
    fetchedAddress.forEach((location) {
      address addressObj = address();
      String new1 = '';
      if (location["houseNumber"] != null) {
        new1 += "House Number:" + location["houseNumber"] + ", ";
        addressObj.houseNumber = location["houseNumber"];
      }
      if (location["floorNumber"] != null) {
        new1 += "Floor Number" + location["floorNumber"] + ", ";
        addressObj.floorNumber = location["floorNumber"];
      }
      new1 += location["fullAddress"] + "-";
      new1 += location["pincode"];
      addressObj.fullAddress = new1;
      addressObj.pincode = location["pincode"];
      addressObj.firstName = location['firstName'];
      addressObj.phoneNumber = location['phoneNumber'];
      fullAddress.add(addressObj);
    });
    setState(() {
      concatenatedAddressList = fullAddress;
    });

    if (concatenatedAddressList.length != 0) {
      dataPresent = true;
    }
  }

  // List<String> concatenatedAddressList1 = List.generate(18,
  //     (index) => '4/5, 1st cross road, Byrappa Layout, whitefield, Bangalore');

  bool isButtonEnabled = false;
  bool isconcatenatedAddressListNotPresent = false;
  int visibleItemCount = 5;

  void _loadMoreconcatenatedAddressList() {
    setState(() {
      if (visibleItemCount < concatenatedAddressList.length) {
        visibleItemCount += 5;
      } else {
        visibleItemCount = visibleItemCount;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      globalservice.showLoader();
      concatenateAddressList();
    });
    Future.delayed(Duration(seconds: 1), () {
      globalservice.hideLoader();
    });
  }

  //Remove address in local and databse
  void _removeItem(int index) {
    setState(() {
      //String f = concatenatedAddressList[index];
      concatenatedAddressList.removeAt(index);
      UserRepository.instance.deleteAddress(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = false;

    bool isconcatenatedAddressListNotPresent = false;

    if (concatenatedAddressList.length == 0) {
      isconcatenatedAddressListNotPresent = true;
    }
    if (concatenatedAddressList.length < visibleItemCount &&
        isconcatenatedAddressListNotPresent == false) {
      visibleItemCount = concatenatedAddressList.length;
    }
    if (visibleItemCount < concatenatedAddressList.length) {
      isButtonEnabled = true;
    }
    //print(widget.routeDetails.toString() + " hii");
    return Column(
      children: [
        widget.routeDetails.toString() != "InitialAdress"
            ? InkWell(
                onTap: () {
                  globalservice.navigate(
                      context, AddAdress(routeInfo: widget.routeDetails));
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Add Address",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        )),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
        Divider(
          height: 5,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Saved addresses",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isconcatenatedAddressListNotPresent
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No Saved Address",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Divider(
                    height: 20,
                  )
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  itemCount:
                      visibleItemCount + 1, // Add 1 for the "Load More" button
                  itemBuilder: (context, index) {
                    //final item = concatenatedAddressList[index];
                    if (index < visibleItemCount) {
                      return GestureDetector(
                        onTap: () async {
                          if (widget.routeDetails.toString() ==
                              "InitialAdress") {
                            myController.updateGlobalString(
                                concatenatedAddressList[index]
                                    .pincode
                                    .toString());
                            BuildContext currentContext = context;
                            //globalservice.showLoader();

                            globalservice.showLoader();
                            await Future.delayed(Duration(seconds: 1), () {
                              globalservice.hideLoader();
                              Get.offAll(() => HomePage());

                              //globalservice.navigate(context, HomePage());
                            });
                          }
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.home,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        concatenatedAddressList[index]
                                                .firstName
                                                .toString() +
                                            ", " +
                                            concatenatedAddressList[index]
                                                .phoneNumber
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                      subtitle: Text(
                                          concatenatedAddressList[index]
                                              .fullAddress
                                              .toString()),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _removeItem(index);
                                    },
                                    child: Icon(Icons.delete,
                                        color: Colors.red.shade900),
                                  )
                                ],
                              ),
                              Divider(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return isButtonEnabled
                          ? ElevatedButton(
                              onPressed: _loadMoreconcatenatedAddressList,
                              child: Text('Load More'),
                            )
                          : null;
                    }
                  },
                ),
              )
      ],
    );
  }
}
