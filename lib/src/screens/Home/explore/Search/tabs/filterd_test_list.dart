import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';

class TestListScreen extends StatelessWidget {
  final List<String> suggestions = [
    'Suggestion 1',
    'Suggestion 2',
    'Suggestion 3',
  ];

  TestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return ListView.builder(
      itemCount: searchState.filteredTests.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchState.filteredTests[index].test.toString()),
        );
      },
    );
  }
}
