import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';

import '../../../../../utils/helper_widgets/list_tile.dart';

class LabListScreen extends StatelessWidget {
  final List<String> suggestions = [
    'Suggestion 1',
    'Suggestion 2',
    'Suggestion 3',
  ];

  LabListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return ListView.builder(
      itemCount: searchState.filteredLabs.length,
      itemBuilder: (context, index) {
        return CustomListTile(
            title: searchState.filteredLabs[index].name,
            icon: Icons.store_outlined,
            subtitle: "lab");
      },
    );
  }
}
