import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/models/package/package.dart';
import 'package:sample_application/src/screens/Home/package/packageService.dart';
import '../../../global_service/global_service.dart';
import '../../../utils/Provider/selected_order_provider.dart';
import '../../../utils/Provider/selected_test_provider.dart';
import '../../../utils/helper_widgets/bottom_model_sheet.dart';
import '../../../utils/helper_widgets/package_card.dart';
import '../../../utils/helper_widgets/slot-booking-card.dart';
import '../models/order/order.dart';
import 'package-detailPage.dart';
import '../models/package/packageCard.dart';
import '../order_tracker/payment/paymentScreen.dart';
import '../order_tracker/step1/step1.dart';

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
              element.medCaPackageCode == package.medCaPackageCode &&
              element.labCode == package.labCode)
          .isNotEmpty);
    }

    void onBookButton(Package packageObj) {
      if (selectedPackage.getSelectedPackage.contains(packageObj)) {
        selectedPackage.removePackage(packageObj);
      } else {
        List<Package> duplicateTest = selectedPackage.getSelectedPackage
            .where((element) =>
                element.medCaPackageCode == packageObj.medCaPackageCode)
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
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
                        price: list[index].price!,
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
            bottom: 100,
            right: 0,
            left: 0,
            child: SwipeableContainer(
                key: UniqueKey(),
                removeTest: (tesCode) {
                  selectedPackage.removeTest(tesCode);
                  if (selectedPackage.getSelectedTest.isEmpty &&
                      selectedPackage.getSelectedPackage.isEmpty) {
                    selectedPackage.setDetailExpanded(false);
                  }
                },
                removePackage: (pacCode) {
                  selectedPackage.removePackage(pacCode);
                  if (selectedPackage.getSelectedTest.isEmpty &&
                      selectedPackage.getSelectedPackage.isEmpty) {
                    selectedPackage.setDetailExpanded(false);
                  }
                }),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                child: selectedPackage.getSelectedPackage.isNotEmpty ||
                        selectedPackage.getSelectedTest.isNotEmpty
                    ? SlotBookingCard(
                        title:
                            "${selectedPackage.getSelectedPackage.length + selectedPackage.getSelectedTest.length} item Selected",
                        content: "view details",
                        hyperLink: true,
                        buttonClicked: () {
                          Order order = selectedOrder.getOrder;

                          Widget widget = order.statusCode == 1
                              ? PaymentScreeen()
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
