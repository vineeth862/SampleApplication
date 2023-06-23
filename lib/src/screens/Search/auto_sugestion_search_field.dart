import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutoSuggestSearchField extends StatelessWidget {
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Jackfruit',
    'Kiwi',
    'Lemon',
    'Mango',
    'Nectarine',
    'Orange',
    'Papaya',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Tangerine',
    'Ugli fruit',
    'Watermelon',
  ];

  AutoSuggestSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: const TextFieldConfiguration(
        decoration: InputDecoration(
          hintText: 'Search Lab/Test',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
      scrollController: ScrollController(),
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        hasScrollbar: true,
        constraints:
            BoxConstraints(maxHeight: 200), // Specify the maximum height
      ),
      suggestionsCallback: (pattern) async {
        return suggestions
            .where((suggestion) =>
                suggestion.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        // Perform the desired action when a suggestion is selected
        print('Selected: $suggestion');
      },
    );
  }
}
