import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filtered_list.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';

import '../../../../../utils/helper_widgets/list_tile.dart';
import '../../../../../utils/helper_widgets/no_result_found.dart';

class LabListScreen extends StatelessWidget {
  LabListScreen({super.key});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return searchState.getlabSuggetionList.isEmpty
        ? SingleChildScrollView(
            child: NoResultFoundCard(
            title: 'No available lab in this search',
          ))
        : ListView.builder(
            itemCount: searchState.getlabSuggetionList.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                title: searchState.getlabSuggetionList[index].labName,
                icon: Icons.store_outlined,
                subtitle: "lab",
                labCode: searchState.getlabSuggetionList[index].labName,
                testCode: '',
                onTap: (title, labCode, tesCode) async {
                  await searchState.cardClicked(title);
                  globalservice.navigate(
                      context,
                      FilteredCardlistPage(
                        title: title,
                        category: "lab",
                      ));
                },
              );
            },
          );
  }
}
