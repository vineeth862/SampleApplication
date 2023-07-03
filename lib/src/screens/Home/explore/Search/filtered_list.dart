import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/card_detail_page.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';
import 'package:sample_application/src/utils/helper_widgets/card.dart';

class FilteredCardlistPage extends StatelessWidget {
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();
  String title;

  FilteredCardlistPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: exploreService.labList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CardWidget(
                    title: exploreService.labList[index].name,
                    description: exploreService.labList[index].test.toString(),
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
