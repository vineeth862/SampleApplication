import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';

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
        return ListTile(
          onTap: () {
            // counterState.increment();
          },
          title: Text(searchState.filteredLabs[index].name),
        );
      },
    );
  }
}
