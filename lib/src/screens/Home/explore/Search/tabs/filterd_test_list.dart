import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filtered_list.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/utils/helper_widgets/list_tile.dart';

class TestListScreen extends StatelessWidget {
  TestListScreen({super.key});
  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return ListView.builder(
      itemCount: searchState.gettestSuggetionList.length,
      itemBuilder: (context, index) {
        return CustomListTile(
          title: searchState.gettestSuggetionList.elementAt(index),
          icon: Icons.medical_services,
          subtitle: "test",
          onTap: (title) async {
            await searchState.cardClicked(title);
            globalservice.navigate(
                context,
                FilteredCardlistPage(
                  title: title,
                  category: "test",
                ));
          },
        );
      },
    );
  }
}
