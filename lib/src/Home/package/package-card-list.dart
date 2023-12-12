import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/package/package.dart';
import 'package:sample_application/src/Home/package/packageService.dart';
import 'package:sample_application/src/core/helper_widgets/price_container.dart';

import '../../core/Provider/selected_order_provider.dart';
import '../../core/Provider/selected_test_provider.dart';
import '../../core/globalServices/global_service.dart';
import '../../core/helper_widgets/package_card.dart';
import '../../core/helper_widgets/slot-booking-card.dart';
import '../models/order/order.dart';
import '../models/package/packageCard.dart';
import '../order_tracker/order-summary/orderSumaryScreen.dart';
import '../order_tracker/step1/step1.dart';
import 'package-detailPage.dart';

class PackageCardlistPage extends StatefulWidget {
  String title;
  String category;

  PackageCardlistPage({super.key, required this.title, required this.category});

  @override
  State<PackageCardlistPage> createState() => _PackageCardlistPage();
}

class _PackageCardlistPage extends State<PackageCardlistPage> {
  // ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();
  PackageService packageService = PackageService();
  num slotBookingCardHeight = 120;
  bool expandDetails = false;

  @override
  void initState() {
    super.initState();
    loadList();
  }

  loadList() async {
    await packageService.getAllLabsByPackage(widget.title);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedPackage = Provider.of<SelectedTestState>(context);
    final selectedOrder = Provider.of<SelectedOrderState>(context);
    List<PackageCard> list = packageService.packageList;
    bool isPackageSelected(Package package) {
      return (selectedPackage.getSelectedPackage
          .where((element) =>
              element.medCapPackageCode == package.medCapPackageCode &&
              element.labCode == package.labCode)
          .isNotEmpty);
    }

    void onBookButton(Package packageObj) {
      if (selectedPackage.getSelectedPackage.contains(packageObj)) {
        selectedPackage.removePackage(packageObj);
      } else {
        List<Package> duplicateTest = selectedPackage.getSelectedPackage
            .where((element) =>
                element.medCapPackageCode == packageObj.medCapPackageCode)
            .toList();

        if (duplicateTest.isNotEmpty) {
          selectedPackage.removePackage(duplicateTest[0]);
        } else {
          selectedPackage.addPackage(packageObj);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: PackageCardWidget(
                        title: list[index].pacName!,
                        package: list[index].packageObject!,
                        testList: list[index].testList!,
                        price: list[index].price.toString(),
                        isTest: false,
                        isTestSelected:
                            isPackageSelected(list[index].packageObject!),
                        tapOnButton: (package) {
                          onBookButton(list[index].packageObject!);

                          globalservice.navigate(context, StepOneToBookTest());

                          if (selectedPackage.getSelectedPackage.isEmpty) {
                            selectedPackage.setDetailExpanded(false);
                          }
                        },
                        tapOnCard: (value) {
                          globalservice.navigate(
                              context,
                              PackageDetailPage(
                                  package: list[index].packageObject!));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                child: selectedPackage.getSelectedPackage.isNotEmpty ||
                        selectedPackage.getSelectedTest.isNotEmpty
                    ? SlotBookingCard(
                        selectedCount: selectedPackage.getSelectedTest.length +
                            selectedPackage.selectedPackage.length,
                        title: " Test/Package Selected",
                        contentColor: false,
                        content: Price(
                          finalAmount: selectedPackage.getTotalSum(),
                          discount: "10",
                          discountedAmount: "100",
                          isTotalPricePresent: true,
                        ),
                        height: slotBookingCardHeight,
                        subContent: "",
                        hyperLink: false,
                        buttonClicked: () {
                          Order order = selectedOrder.getOrder;

                          Widget widget = order.statusCode == 1
                              ? OrderSummaryScreen()
                              : StepOneToBookTest();

                          globalservice.navigate(context, widget);
                        },
                        expandDetail: () {
                          setState(() {
                            expandDetails = true;
                          });
                        },
                      )
                    : Card()),
          ),
        ],
      ),
    );
  }
}
