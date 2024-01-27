import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/Home/package/package-card.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/package/package-card-list.dart';
import 'package:sample_application/src/Home/package/packageService.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/helper_widgets/location_unavailable_card.dart';

import '../../core/Provider/selected_test_provider.dart';

class PackageSuggetionList extends StatefulWidget {
  PackageSuggetionList({super.key, required this.title, required this.labCode});
  String labCode;
  String title;
  @override
  State<PackageSuggetionList> createState() => _PackageSuggetionList();
}

class _PackageSuggetionList extends State<PackageSuggetionList> {
  PackageService packageService = PackageService();
  late SelectedTestState selectedTest;
  @override
  void initState() {
    Future(() {
      loadList(widget.labCode, widget.title);
    });
  }

  loadList(String labCode, String title) async {
    if (labCode.isEmpty && title.isEmpty) {
      await packageService.loadPackageList();
    } else if (title.isNotEmpty) {
      await packageService.loadPackageListByTitle(widget.title);
    } else {
      await packageService.loadPackageListByLabCode(widget.labCode);
    }

    setState(() {});
  }

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage());
        return await true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Choose Your Package"),
          ),
          body: Obx(() => (UserCurrentLocation.instance.pinCodeExists.value)
              ? Container(
                  child: ListView.builder(
                    itemCount: packageService.allPackagesNameList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            globalservice.navigate(
                                context,
                                PackageCardlistPage(
                                  category: packageService.allPackagesNameList
                                      .elementAt(index),
                                  title: packageService.allPackagesNameList
                                      .elementAt(index),
                                ));
                          },
                          child: packageCard(
                              displayName: packageService.allPackagesNameList
                                  .elementAt(index),
                              logo: "package")
                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Container(
                          //     height: 80,
                          //     child: Card(
                          //         margin: EdgeInsets.only(
                          //             top: 5, left: 10, right: 10, bottom: 5),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10.0),
                          //         ),
                          //         elevation: 2,
                          //         color:
                          //             Color.fromARGB(255, 201, 243, 205).withOpacity(0.5),
                          //         child: Center(
                          //           child: Row(
                          //             children: [
                          //               SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Icon(
                          //                 Icons.medical_services_rounded,
                          //               ),
                          //               SizedBox(
                          //                 width: 20,
                          //               ),
                          //               Expanded(
                          //                 child: ListTile(
                          //                   title: Text(
                          //                     packageService.allPackagesNameList
                          //                         .elementAt(index),
                          //                     style: Theme.of(context).textTheme.bodyLarge,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         )),
                          //   ),
                          // ),
                          );
                    },
                  ),
                )
              : LocationNotAvailable())),
    );
  }
}
