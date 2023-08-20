import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/profile/adress_book.dart';
import 'package:sample_application/src/screens/userAdress/add_address.dart';
import 'package:sample_application/src/utils/Provider/loading_provider.dart';

class addressOperation extends StatefulWidget {
  final Widget routeDetails;
  addressOperation({super.key, required this.routeDetails});

  @override
  State<addressOperation> createState() => _addressOperationState();
}

class _addressOperationState extends State<addressOperation> {
  GlobalService globalservice = GlobalService();
  var Controller = Get.put((UserRepository()));
  late LoadingProvider loadingProvider;

  concatenatedAddressList() async {
    List<Map<String, dynamic>> items2 =
        await UserRepository.instance.getAdress();
    bool dataPresent = false;
    List<String> fullAddress = [];
    items2.forEach((location) {
      String new1 = '';
      if (location["houseNumber"] != null) {
        new1 += "House Number:" + location["houseNumber"] + ", ";
      }
      if (location["floorNumber"] != null) {
        new1 += "Floor Number" + location["floorNumber"] + ", ";
      }
      new1 += location["fullAddress"] + "-";
      new1 += location["pincode"];

      fullAddress.add(new1);
    });

    items = fullAddress;
    if (items.length != 0) {
      dataPresent = true;
    }
  }

  // List<String> items1 = List.generate(18,
  //     (index) => '4/5, 1st cross road, Byrappa Layout, whitefield, Bangalore');
  late List<String> items = [];
  bool isButtonEnabled = false;
  bool isItemsNotPresent = false;
  int visibleItemCount = 5;

  void _loadMoreItems() {
    setState(() {
      if (visibleItemCount < items.length) {
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
      loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.startLoading();
      concatenatedAddressList();
    });

    Future.delayed(Duration(seconds: 1), () {
      loadingProvider.stopLoading();
    });
  }

  //Remove address in local and databse
  void _removeItem(int index) {
    setState(() {
      String f = items[index];
      items.removeAt(index);
      UserRepository.instance.deleteAddress(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    bool isButtonEnabled = false;

    bool isItemsNotPresent = false;
    if (items.length == 0) {
      isItemsNotPresent = true;
    }
    if (items.length < visibleItemCount && isItemsNotPresent == false) {
      visibleItemCount = items.length;
    }
    if (visibleItemCount < items.length) {
      isButtonEnabled = true;
    }
    return loadingProvider.isLoading
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(160.0),
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Theme.of(context).colorScheme.primary],
                strokeWidth: 10,
              ),
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 3,
              ),
              InkWell(
                onTap: () {
                  //

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
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
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
                          style: Theme.of(context).textTheme.titleLarge,
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
                        itemCount: visibleItemCount +
                            1, // Add 1 for the "Load More" button
                        itemBuilder: (context, index) {
                          if (index < visibleItemCount) {
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.home,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(items[index]),
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
                            );
                          } else {
                            return isButtonEnabled
                                ? ElevatedButton(
                                    onPressed: _loadMoreItems,
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
