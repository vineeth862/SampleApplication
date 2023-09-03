import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filter-test-list.dart';

import '../../../global_service/global_service.dart';
import '../../../utils/Provider/search_provider.dart';

class LabTestCategoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;

  LabTestCategoryCard(this.title, this.content, this.imagePath);
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return GestureDetector(
      onTap: () async {
        await searchState.categoryClicked(title);
        globalservice.navigate(
            context,
            FilteredTestCardlistPage(
              title: title,
              category: content,
            ));
      },
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.10,
              backgroundImage: NetworkImage(imagePath),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.025,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
