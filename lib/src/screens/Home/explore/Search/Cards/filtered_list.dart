import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/utils/helper_widgets/card.dart';

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
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CardWidget(
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
