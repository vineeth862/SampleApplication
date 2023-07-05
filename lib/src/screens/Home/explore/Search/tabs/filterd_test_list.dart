import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';
import 'package:sample_application/src/utils/helper_widgets/list_tile.dart';

class TestListScreen extends StatelessWidget {
  TestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return ListView.builder(
      itemCount: searchState.filteredTests.length,
      itemBuilder: (context, index) {
        return CustomListTile(
            title: searchState.filteredTests.elementAt(index),
            icon: Icons.medical_services,
            subtitle: "test");
      },
    );
  }
}
