import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/explore/Search/search_field.dart';
import 'package:sample_application/src/core/helper_widgets/slot-booking-card.dart';

import '../../../../core/Provider/search_provider.dart';
import '../../../../core/Provider/selected_order_provider.dart';
import '../../../../core/Provider/selected_test_provider.dart';
import '../../../../core/globalServices/global_service.dart';
import '../../../../core/helper_widgets/test_card.dart';
import '../../../models/order/order.dart';
import '../../../models/test/test.dart';
import '../../../models/test/testcard.dart';
import '../../../order_tracker/order-summary/orderSumaryScreen.dart';
import '../../../order_tracker/step1/step1.dart';
import '../../explore.service.dart';
import 'card_detail_page.dart';

class FilteredLabCardlistPage extends StatefulWidget {
  String title;
  String location;
  String labCode;
  String logo;

  FilteredLabCardlistPage(
      {required this.title,
      required this.location,
      required this.labCode,
      required this.logo});
  @override
  _FilteredLabCardlistPage createState() => _FilteredLabCardlistPage();
}

class _FilteredLabCardlistPage extends State<FilteredLabCardlistPage> {
  final TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();
  bool _isAppBarExpanded = false;
  num slotBookingCardHeight = 120;
  bool expandDetails = false;

  getLabLogoLocation(labCode) async {
    var logoList = await globalservice.getLogo(labCode);
    var locationList = await globalservice.getLabLocation(labCode);
    // widget.logo = logoList[0];
    // widget.location = locationList[0];
    setState(() {
      widget.logo = logoList[0];
      widget.location = locationList[0];
    });
    //widget.logo = await globalservice.getLogo(labCode)[0];
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      globalservice.showLoader();
    });
    if (widget.logo == "logo" && widget.location == 'location') {
      getLabLogoLocation(widget.labCode);
      //getLabLocation(widget.labCode);
    }
    globalservice.hideLoader();
    _scrollController.addListener(() {
      setState(() {
        _isAppBarExpanded = _scrollController.offset > 143.0;
        // Adjust the value as needed
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    final selectedOrder = Provider.of<SelectedOrderState>(context);
    List<TestCard> list = searchState.getTestCardList;
    bool _isInputEmpty = true;

    bool isTestSelected(Test test) {
      return (selectedTest.getSelectedTest
          .where((element) =>
              element.medCapTestCode == test.medCapTestCode &&
              element.labCode == test.labCode)
          .isNotEmpty);
    }

    void onBookButton(Test testObject, Order order) {
      if (selectedTest.getSelectedTest.contains(testObject)) {
        selectedTest.removeTest(testObject);
      } else {
        List<Test> duplicateTest = selectedTest.getSelectedTest
            .where((element) =>
                element.medCapTestCode == testObject.medCapTestCode)
            .toList();
        if (duplicateTest.isNotEmpty) {
          selectedTest.removeTest(duplicateTest[0]);
        } else {
          selectedTest.addTest(testObject);
        }
        order.tests = selectedTest.getSelectedTest;
        selectedOrder.setOrder = order;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              leading: null,
              automaticallyImplyLeading: false,
              title: _isAppBarExpanded
                  ? Container(
                      padding: EdgeInsets.only(
                          left: 0, top: 10, right: 35, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          iconColor: Theme.of(context).colorScheme.primary,
                          hintText: 'Search Any Test here',
                          filled: true,
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          fillColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          prefixIcon: const Icon(Icons.search),
                          contentPadding:
                              const EdgeInsets.fromLTRB(-20, 0, 5, 0),
                          suffixIcon: _searchController.value.text.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      searchState.search("");
                                    });
                                  },
                                ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        // style: const TextStyle(color: Color.fromARGB(255, 43, 42, 42)),
                        onChanged: (value) async {
                          _isInputEmpty = value.isEmpty;
                          await searchState.searchTestByLabCode(
                              value, widget.labCode);
                        },
                      ),
                    )
                  : Container(),
              expandedHeight: !_isAppBarExpanded ? 120.0 : 0.0,
              flexibleSpace: FlexibleSpaceBar(
                background: !_isAppBarExpanded
                    ? SafeArea(
                        child: Container(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.9),
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Opacity(
                                    opacity: 0.1,
                                    child: Image.memory(
                                      globalservice
                                          .getImageByteCode(widget.logo),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(widget.title.toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                color: Color.fromARGB(
                                                    255, 1, 5, 3))),
                                    ListTile(
                                      //leading: Icon(Icons.location_on_outlined),
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      title: Text(widget.location.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              floating: true,
              pinned: true,
              centerTitle: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: TestCardWidget(
                        isTest: false,
                        title: list[index].name,
                        test: list[index].testObject,
                        cardName: list[index].labName,
                        price: list[index].price,
                        isTestSelected: isTestSelected(list[index].testObject),
                        tapOnButton: (test) {
                          Order order = selectedOrder.getOrder;
                          onBookButton(list[index].testObject, order);

                          if (selectedTest!.getSelectedPackage.length == 0 &&
                              selectedTest!.getSelectedTest.length == 0) {
                          } else if (order.statusCode == 1) {
                            Get.off(() => OrderSummaryScreen());
                          } else if (globalservice.getLength(order.tests) > 0 ||
                              globalservice.getLength(order.packages) > 0) {
                            //globalservice.navigate(context, StepOneToBookTest());
                          } else {
                            Get.off(() => SearchBarPage());
                          }

                          if (selectedTest.getSelectedTest.isEmpty &&
                              selectedTest.getSelectedPackage.isEmpty) {
                            selectedTest.setDetailExpanded(false);
                          }
                        },
                        tapOnCard: (value) {
                          globalservice.navigate(
                              context,
                              CardDetailPage(
                                test: list[index].testObject,
                              ));
                        }),
                  );
                },
                childCount: list.length,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              child: (selectedTest.getSelectedTest.isNotEmpty ||
                      selectedTest.getSelectedPackage.isNotEmpty)
                  ? SlotBookingCard(
                      selectedCount: selectedTest.getSelectedTest.length +
                          selectedTest.getSelectedPackage.length,
                      title: " Test/Package Selected",
                      contentColor: false,
                      content: "view details",
                      subContent: "",
                      height: slotBookingCardHeight,
                      hyperLink: true,
                      buttonClicked: () {
                        Order order = selectedOrder.getOrder;
                        if (selectedTest!.getSelectedPackage.length == 0 &&
                            selectedTest!.getSelectedTest.length == 0) {
                        } else if (order.statusCode == 1) {
                          Get.off(() => OrderSummaryScreen());
                        } else {
                          globalservice.navigate(context, StepOneToBookTest());
                        }
                      },
                      expandDetail: () {
                        setState(() {
                          expandDetails = true;
                        });
                      },
                    )
                  : Card()),
        ),
      ]),
    );
  }
}
