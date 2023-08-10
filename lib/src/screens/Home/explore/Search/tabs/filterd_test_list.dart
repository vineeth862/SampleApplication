import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filtered_list.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/utils/helper_widgets/list_tile.dart';
import '../../../../../utils/helper_widgets/no_result_found.dart';

class TestListScreen extends StatelessWidget {
  TestListScreen({super.key});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return searchState.gettestSuggetionList.isEmpty
        ? SingleChildScrollView(
            child: NoResultFoundCard(
            title: 'No available test in this search',
          ))
        : ListView.builder(
            itemCount: searchState.gettestSuggetionList.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                title:
                    searchState.gettestSuggetionList.elementAt(index).testname,
                icon: Icons.medical_services,
                labCode:
                    searchState.gettestSuggetionList.elementAt(index).labCode,
                testCode: searchState.gettestSuggetionList
                    .elementAt(index)
                    .hf_test_code,
                subtitle:
                    searchState.gettestSuggetionList.elementAt(index).labName,
                onTap: (title, labCode, testCode) async {
                  await searchState.cardClicked(testCode, true);
                  globalservice.navigate(
                      context,
                      FilteredCardlistPage(
                        title: title,
                        category: searchState.gettestSuggetionList
                            .elementAt(index)
                            .test_code,
                      ));
                },
              );
            },
          );
  }
}
