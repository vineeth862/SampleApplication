import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/explore/category/filtered_category_list.dart';

import '../../../core/Provider/search_provider.dart';
import '../../../core/globalServices/global_service.dart';

class LabTestCategoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  final List testList;

  LabTestCategoryCard(this.title, this.content, this.imagePath, this.testList);
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return GestureDetector(
      onTap: () {
        globalservice.navigate(
            context,
            FilterCategoryListPage(
              sexCategory: title,
              testList: testList,
            ));
      },
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // Set your desired corner radius
                  child: Image.memory(
                    globalservice.getImageByteCode(imagePath),
                    // height: 80.0,
                    // width: 120.0,
                    fit: BoxFit
                        .fill, // Adjust this to control the image size within its parent widget
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class MaleFemaleCategory extends StatelessWidget {
  final String? title;
  final String? imagePath;
  final List? testList;
  const MaleFemaleCategory(
      {super.key, this.title, this.imagePath, this.testList});

  @override
  Widget build(BuildContext context) {
    GlobalService globalservice = GlobalService();
    return GestureDetector(
      onTap: () {
        globalservice.navigate(
            context,
            FilterCategoryListPage(
              sexCategory: title,
              testList: testList,
            ));
      },
      child: Card(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxHeight: 100, minHeight: 50, maxWidth: 100, minWidth: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.memory(
                    globalservice.getImageByteCode(imagePath),
                    height: 80.0,
                    width: 120.0,
                    fit: BoxFit
                        .fill, // Adjust this to control the image size within its parent widget
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer,
                    ]),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "      " + title.toString() + "      ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )),
          )
        ],
      )),
    );
  }
}
