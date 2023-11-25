import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/Home/explore/Search/Cards/filter-test-list.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/core/helper_widgets/list_tile.dart';

import '../../../../core/helper_widgets/no_result_found.dart';

class TestListScreen extends StatelessWidget {
  TestListScreen({super.key});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return searchState.gettestSuggetionList.isEmpty
        ? Center(
            child: SingleChildScrollView(
                child: NoResultFoundCard(
              title: 'No available test in this search',
            )),
          )
        : Column(children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(12),
              child: searchState.input.isEmpty
                  ? const Text(
                      "Popular Tests",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3),
                    )
                  : const Text(
                      "Searched Results!",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3),
                    ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: searchState.gettestSuggetionList.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  title: searchState.gettestSuggetionList
                      .elementAt(index)
                      .displayName,
                  icon: ClipOval(
                    child: Container(
                      width: 20,
                      height: 30,
                      //color: Theme.of(context).colorScheme.tertiary,
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      child: Image.asset(
                        "./assets/images/blood-test.png",
                        // scale: 1,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  labCode:
                      searchState.gettestSuggetionList.elementAt(index).labCode,
                  testCode: searchState.gettestSuggetionList
                      .elementAt(index)
                      .medCapTestCode,
                  // subtitle:
                  //     searchState.gettestSuggetionList.elementAt(index).labName,
                  onTap: (title, labCode, testCode) async {
                    await searchState.cardClicked(testCode, true);
                    // ignore: use_build_context_synchronously
                    globalservice.navigate(
                        context,
                        FilteredTestCardlistPage(
                          title: title,
                          category: searchState.gettestSuggetionList
                              .elementAt(index)
                              .medCapTestCode,
                        ));
                  },
                );
              },
            ))
          ]);
  }
}
