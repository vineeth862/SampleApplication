import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../global_service/global_service.dart';
import '../../../../../utils/Provider/search_provider.dart';
import '../../../../../utils/Provider/selected_test_provider.dart';
import '../../../../../utils/helper_widgets/test_card.dart';
import '../../../models/test/test_card.dart';
import '../../../order_tracker/step1/step1.dart';
import '../../explore.service.dart';
import 'card_detail_page.dart';

class FilteredLabCardlistPage extends StatefulWidget {
  String title;
  String location;
  String labCode;
  FilteredLabCardlistPage(
      {required this.title, required this.location, required this.labCode});
  @override
  _FilteredLabCardlistPage createState() => _FilteredLabCardlistPage();
}

class _FilteredLabCardlistPage extends State<FilteredLabCardlistPage> {
  final TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();
  bool _isAppBarExpanded = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isAppBarExpanded = _scrollController.offset > 143.0;
        // Adjust the value as needed
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    final selectedTest = Provider.of<SelectedTestState>(context);
    List<TestCard> list = searchState.getTestCardList;
    bool _isInputEmpty = true;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: _isAppBarExpanded
                ? Container(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 35, bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        iconColor: Theme.of(context).colorScheme.primary,
                        hintText: 'Search Any Test here',
                        filled: true,
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        fillColor:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.fromLTRB(-20, 0, 5, 0),
                        suffixIcon: _searchController.value.text.isEmpty
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
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                      // style: const TextStyle(color: Color.fromARGB(255, 43, 42, 42)),
                      onChanged: (value) async {
                        _isInputEmpty = value.isEmpty;
                        await searchState.searchTest(value, widget.labCode);
                      },
                    ),
                  )
                : Container(),
            expandedHeight: !_isAppBarExpanded ? 200.0 : 0.0,
            flexibleSpace: FlexibleSpaceBar(
              background: !_isAppBarExpanded
                  ? SafeArea(
                      child: Container(
                        color: Color.fromARGB(255, 247, 216, 241),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                widget.title.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on_outlined),
                                titleAlignment: ListTileTitleAlignment.center,
                                title: Text(
                                  widget.location.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
            floating: true,
            pinned: true,
            centerTitle: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TestCardWidget(
                    title: list[index].name,
                    description: list[index].test.toString(),
                    price: list[index].price,
                    isTestSelected: !selectedTest.getSelectedTest
                        .contains(list[index]?.testObject),
                    tapOnButton: (test) {
                      if (selectedTest.getSelectedTest
                          .contains(list[index]?.testObject))
                        selectedTest.removeTest(list[index]?.testObject);
                      else
                        selectedTest.addTest(list[index]?.testObject);

                      globalservice.navigate(context, StepOneToBookTest());

                      if (selectedTest.getSelectedTest.isEmpty) {
                        selectedTest.setDetailExpanded(false);
                      }
                    },
                    tapOnCard: (value) {
                      globalservice.navigate(
                          context,
                          CardDetailPage(
                            test: list[index].testObject,
                          ));
                    });
              },
              childCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
