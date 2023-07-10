import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/utils/helper_widgets/lab_card.dart';

// ignore: must_be_immutable
class FilteredCardlistPage extends StatelessWidget {
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();
  String title;
  String category;

  FilteredCardlistPage(
      {super.key, required this.title, required this.category});
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    List<dynamic> list = searchState.getTestCardList.isEmpty
        ? searchState.getLabCardList
        : searchState.getTestCardList;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return LabCardWidget(
                    title: list[index].name,
                    description: list[index].test.toString(),
                    onTap: (value) {
                      globalservice.navigate(context, const CardDetailPage());
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
