// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/global_service/user_location.dart';
import 'package:sample_application/src/screens/Home/explore/Search/tabs/filterd_test_list.dart';
import 'package:sample_application/src/screens/Home/explore/Search/tabs/filtered_lab_list.dart';
import 'package:sample_application/src/screens/userAdress/initial_adress.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/utils/helper_widgets/location_unavailable_card.dart';
import 'package:sample_application/src/utils/themes/themedata.dart';

import '../../../../global_service/global_service.dart';

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
  late SearchListState searchState;
  final TextEditingController _searchController = TextEditingController();
  // static UserCurrentLocation get instance => Get.find();
  // RxString globalString = 'Fetching adress...'.obs;
  GlobalService globalservice = GlobalService();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(milliseconds: 0),
        () => searchState.searchPriorityTestAndLabs());
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

  void search(value) async {
    _isInputEmpty = value.isEmpty;
    await searchState.search(value.trim());
    if (value.trim().isNotEmpty &&
        searchState.filteredTests.isEmpty &&
        searchState.filteredLabs.isNotEmpty) {
      switchToTab(0);
    } else if (value.trim().isNotEmpty &&
        searchState.filteredTests.isNotEmpty &&
        searchState.filteredLabs.isEmpty) {
      switchToTab(1);
    }
    if (value.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (value.isEmpty) {
          searchState.resetSearchList();
          searchState.searchPriorityTestAndLabs();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    searchState = Provider.of<SearchListState>(context);
    final myController = Get.find<UserCurrentLocation>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      themeMode: ThemeMode.light,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(189, 73, 50, 1), // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.dark, //<-- For Android SEE HERE (dark icons)
              statusBarBrightness:
                  Brightness.light, //<-- For iOS SEE HERE (dark icons)
            ),
            toolbarHeight: 120,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              alignment: Alignment.topCenter,
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Stack(children: [
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          alignment: Alignment.center,
                          color: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Obx(() => Text(
                                  myController.location.value.trim() != ""
                                      ? myController.location.value
                                      : myController.adress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: Colors.white),
                                )),
                            subtitle: Obx(() => Text(
                                  myController.area.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Color.fromARGB(
                                              255, 252, 215, 215)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 15, right: 15),
                  width: MediaQuery.of(context).size.width * 1,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search  Any Labs OR Test',
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      fillColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      prefixIcon: const Icon(Icons.search),
                      // contentPadding: const EdgeInsets.fromLTRB(-20, 0, 5, 0),
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
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 217, 217, 217)),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(
                                  5)) // Border color when focused
                          ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 212, 211, 211)),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(
                                  15)) // Border color when not focused
                          ),
                    ),
                    // style: const TextStyle(color: Color.fromARGB(255, 43, 42, 42)),
                    onChanged: (value) {
                      search(value);
                    },
                  ),
                ),
              ]),
            ],
            backgroundColor: Theme.of(context).colorScheme.background,
            // automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              // indicatorColor: Colors.white,
              tabs: const [Tab(text: 'Labs'), Tab(text: 'Tests')],
            ),
          ),
          body: Obx(() => (myController.pinCodeExists.value)
              ? Stack(
                  children: [
                    TabBarView(
                      controller: _tabController,
                      children: [
                        LabListScreen(),
                        TestListScreen(),
                      ],
                    ),
                  ],
                )
              : LocationNotAvailable()),
        ),
      ),
    );
  }
}
