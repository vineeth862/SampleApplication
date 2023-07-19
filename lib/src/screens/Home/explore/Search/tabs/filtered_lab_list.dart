import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filtered_list.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';

import '../../../../../utils/helper_widgets/list_tile.dart';

class LabListScreen extends StatelessWidget {
  final List<String> suggestions = [
    'Suggestion 1',
    'Suggestion 2',
    'Suggestion 3',
  ];

  LabListScreen({super.key});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return ListView.builder(
      itemCount: searchState.getlabSuggetionList.length,
      itemBuilder: (context, index) {
        return CustomListTile(
          title: searchState.getlabSuggetionList[index].name,
          icon: Icons.store_outlined,
          subtitle: "lab",
          onTap: (title) async {
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
