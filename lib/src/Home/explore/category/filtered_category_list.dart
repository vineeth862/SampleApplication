// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/explore/Search/Cards/filter-test-list.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/core/helper_widgets/category_card.dart';
import 'package:sample_application/src/core/helper_widgets/location_unavailable_card.dart';

class FilterCategoryListPage extends StatefulWidget {
  final String? sexCategory;
  final String? ageGroup;
  final List? testList;
  const FilterCategoryListPage(
      {super.key, this.sexCategory, this.ageGroup, this.testList});

  @override
  State<FilterCategoryListPage> createState() => _FilterCategoryListPageState();
}

class _FilterCategoryListPageState extends State<FilterCategoryListPage> {
  List displayNames = [];

  getMaleCategory() async {
    if (widget.ageGroup != "all") {
      var pList = await FirebaseFirestore.instance
          .collection('packages/category/' + widget.sexCategory.toString())
          .doc(widget.ageGroup)
          .get();

      setState(() {
        displayNames = pList.data()!["testList"] as List;
      });
    } else {
      var pList = await FirebaseFirestore.instance
          .collection('packages/category/' + widget.sexCategory.toString())
          .get();
      pList.docs.forEach((element) {
        displayNames.add(element.data()['testList'][0]);
      });
      Set<String> uniqueDisplayNames = Set<String>.from(displayNames);
      setState(() {
        displayNames = uniqueDisplayNames.toList();
      });
    }
  }

  @override
  void initState() {
    if (widget.testList == null || widget.testList == []) {
      getMaleCategory();
    } else {
      setState(() {
        displayNames = widget.testList!.toList();
      });
    }
  }

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final myController = Get.find<UserCurrentLocation>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.sexCategory![0].toUpperCase() +
                  widget.sexCategory!.substring(1) +
                  " Category",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white)),
        ),
        body: Obx(
          () => (myController.pinCodeExists.value)
              ? Container(
                  child: ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 3, // Number of columns
                    // ),
                    itemCount: displayNames.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {
                            await searchState.categoryClicked(
                                "displayName", displayNames[index]);
                            globalservice.navigate(
                                context,
                                FilteredTestCardlistPage(
                                  title: displayNames[index],
                                  category: displayNames[index],
                                ));
                          },
                          child: categoryCard(
                              displayName: displayNames[index],
                              logo: "category"));
                    },
                  ),
                )
              : LocationNotAvailable(),
        ));
  }
}
