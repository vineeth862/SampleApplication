import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/Home/models/user/address.dart';
import 'package:sample_application/src/core/globalServices/authentication/user_repository.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/widgets/addAddressStepTwo.dart';

class addressOperationStepTwo extends StatefulWidget {
  final Widget routeDetails;
  final Function(Address address) addressSelected;
  addressOperationStepTwo(
      {super.key, required this.routeDetails, required this.addressSelected});

  @override
  State<addressOperationStepTwo> createState() =>
      _addressOperationStepTwoState();
}

class _addressOperationStepTwoState extends State<addressOperationStepTwo> {
  GlobalService globalservice = GlobalService();
  var Controller = Get.put((UserRepository()));

  // concatenatedAddressList() async {
  //   List<Map<String, dynamic>> items2 =
  //       await UserRepository.instance.getAdress();
  //   bool dataPresent = false;
  //   List<String> fullAddress = [];
  //   items2.forEach((location) {
  //     String new1 = '';
  //     if (location["houseNumber"] != null) {
  //       new1 += "House Number:" + location["houseNumber"] + ", ";
  //     }
  //     if (location["floorNumber"] != null) {
  //       new1 += "Floor Number" + location["floorNumber"] + ", ";
  //     }
  //     new1 += location["fullAddress"] + "-";
  //     new1 += location["pincode"];

  //     fullAddress.add(new1);
  //   });
  //   setState(() {
  //     items = fullAddress;
  //     if (items.length != 0) {
  //       dataPresent = true;
  //     }
  //   });
  // }
  List<Address> concatenatedAddressList = [];
  concatenateAddressList() async {
    List<Map<String, dynamic>> fetchedAddress =
        await UserRepository.instance.getAdress();
    //print(fetchedAddress.toList());
    bool dataPresent = false;
    List<Address> fullAddress = [];
    fetchedAddress.forEach((location) {
      Address addressObj = Address();
      String new1 = '';
      // if (location["houseNumber"] != null) {
      //   new1 += "House Number:" + location["houseNumber"] + ", ";
      //   addressObj.houseNumber = location["houseNumber"];
      // }
      // if (location["street"] != null) {
      //   new1 += "street" + location["street"] + ", ";
      //   addressObj.street = location["street"];
      // }
      new1 += location["fullAddress"];
      //new1 += location["pincode"];
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

  // List<String> items1 = List.generate(18,
  //     (index) => '4/5, 1st cross road, Byrappa Layout, whitefield, Bangalore');
  late List<String> items = [];
  bool isButtonEnabled = false;
  bool isItemsNotPresent = false;
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

    concatenateAddressList();
  }

  //Remove address in local and databse
  void _removeItem(int index) {
    setState(() {
      //String f = concatenatedAddressList[index];
      concatenatedAddressList.removeAt(index);
      UserRepository.instance.deleteAddress(index);
    });
  }

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = false;

    bool isItemsNotPresent = false;
    if (concatenatedAddressList.length == 0) {
      isItemsNotPresent = true;
    }
    if (concatenatedAddressList.length < visibleItemCount &&
        isItemsNotPresent == false) {
      visibleItemCount = concatenatedAddressList.length;
    }
    if (visibleItemCount < concatenatedAddressList.length) {
      isButtonEnabled = true;
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                height: 3,
              ),
              // InkWell(
              //   onTap: () {
              //     //Navigator.pop(context);
              //     globalservice.navigate(context, UseCurrentLocationStepTwo());
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
              //             "Use Current Location",
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
              Divider(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Get.off(() => AddAdressStepTwo());
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
              ),
              Divider(
                height: 5,
              ),
              SizedBox(
                height: 20,
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
              isItemsNotPresent
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
                  : ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 380.0),
                      child: ListView.builder(
                        padding: EdgeInsets.all(5),
                        itemCount: visibleItemCount +
                            1, // Add 1 for the "Load More" button
                        itemBuilder: (context, index) {
                          if (index < visibleItemCount) {
                            return InkWell(
                              onTap: () {
                                widget.addressSelected(
                                    concatenatedAddressList[index]);
                                selectedIndex = index;
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      color: selectedIndex == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(0.2)
                                          : Colors.transparent,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          // Icon(
                                          //   Icons.home,
                                          //   color: Theme.of(context)
                                          //       .colorScheme
                                          //       .primary,
                                          // ),
                                          Container(
                                            width: 20,
                                            child: Image.asset(
                                                'assets/images/home.png'),
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
                                                    concatenatedAddressList[
                                                            index]
                                                        .phoneNumber
                                                        .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(),
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .inverseSurface,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      )),
              isButtonEnabled
                  ? SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Color.fromARGB(255, 181, 233, 227);

                              // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: _loadMoreconcatenatedAddressList,
                        child: Text(
                          'Load More',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    )
                  : Card()
            ],
          ),
        ),
      ),
    );
  }
}
