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

  FilteredCardlistPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: searchState.labList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CardWidget(
                    title: searchState.labList[index].name,
                    description: searchState.labList[index].test.toString(),
                    onTap: (value) {
                      globalservice.navigate(context, CardDetailPage());
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
