import 'package:flutter/material.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/filtered_list.dart';
import 'package:sample_application/src/screens/Home/explore/explore.service.dart';

class SearchBarPage extends StatefulWidget {
  SearchBarPage({super.key, required this.filterd});

  Function(List match, dynamic clickedCArd) filterd;
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  ExploreService exploreService = ExploreService();
  GlobalService globalService = GlobalService();
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _isInputEmpty = true;

  List<String> suggestions = [
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
    'Vanilla bean',
    'Watermelon',
    'Xigua melon',
    'Yellow passionfruit',
    'Zucchini'
  ];
  void _onTextChanged(value) {
    setState(() {
      _searchText = value;
      _isInputEmpty = _searchController.text.isEmpty;
      // if (_searchController.text.isEmpty) {
      //   widget.filterd([], null);
      // }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _searchText = _searchController.text;
    });
  }

  List<String> _getFilteredSuggestions(String query) {
    List<String> filteredList = [];
    if (query.isNotEmpty) {
      for (String suggestion in suggestions) {
        if (suggestion.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(suggestion);
        }
      }
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search  Any Labs OR Test',
            filled: true,
            fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.fromLTRB(-20, 0, 5, 0),
            suffixIcon: _isInputEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        widget.filterd([], null);
                      });
                    },
                  ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
          ),
          style: TextStyle(color: Color.fromARGB(255, 43, 42, 42)),
          onChanged: _onTextChanged,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              children: exploreService
                  .getSuggetionList(_searchController.text)
                  .map((e) => Container(
                        padding: EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () {
                            exploreService.filterCardList(e.test, e);
                            this.globalService.navigate(
                                context,
                                FilteredCardlistPage(
                                    title: e.name +
                                        globalService.listToComaSeparateString(
                                            e.test, _searchController.text)));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.search_rounded),
                              SizedBox(width: 16),
                              Text(
                                e.name +
                                    globalService.listToComaSeparateString(
                                        e.test, _searchController.text),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
