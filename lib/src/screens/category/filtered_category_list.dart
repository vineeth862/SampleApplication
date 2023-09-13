import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filter-test-list.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sexCategory![0].toUpperCase() +
            widget.sexCategory!.substring(1) +
            " Category"),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
          ),
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
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                    color: const Color.fromARGB(255, 253, 229, 221),
                    child: Center(
                      child: Text(displayNames[index]),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
