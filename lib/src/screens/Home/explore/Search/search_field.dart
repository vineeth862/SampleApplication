// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/tabs/filterd_test_list.dart';
import 'package:sample_application/src/screens/Home/explore/Search/tabs/filtered_lab_list.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Provider/search_provider.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage>
    with SingleTickerProviderStateMixin {
  bool _isInputEmpty = true;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void switchToTab(int tabIndex) {
    _tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
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
                              searchState.search("");
                            });
                          },
                        ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 43, 42, 42)),
                onChanged: (value) {
                  _isInputEmpty = value.isEmpty;
                  searchState.search(value.trim());
                  if (value.trim().isNotEmpty &&
                      searchState.filteredTests.isEmpty &&
                      searchState.filteredLabs.isNotEmpty) {
                    switchToTab(0);
                  } else if (value.trim().isNotEmpty &&
                      searchState.filteredTests.isNotEmpty &&
                      searchState.filteredLabs.isEmpty) {
                    switchToTab(1);
                  }
                },
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: const [Tab(text: 'Labs'), Tab(text: 'Tests')],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Center(child: LabListScreen()),
              Center(child: TestListScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
